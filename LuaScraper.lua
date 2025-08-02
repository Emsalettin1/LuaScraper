--Import required libraries
local https = require("ssl.https")
local http = require("socket.http")
local ltn12 = require("ltn12")

-- Parse the protocol from a URL string (returns "http" or "https")
local function parseURL(url)
    --check the protocol
    local start_pos, end_pos = string.find(url, "://")
    if start_pos then
        local result = string.sub(url, 1, start_pos - 1)
        return result

    else
        print("Cannot identify the protocol.")
        return nil
    end
end

-- Perform an GET request and return the response
local function getHTML(url, protocol)
    local response = {}
    local body = {}
    local code, responseHeaders

    if protocol == "https" then
        --Make a HTTPS request
        _, code, responseHeaders = https.request{
            url = url,
            method = "GET",
            sink = ltn12.sink.table(body),
        }

    elseif protocol == "http" then
        --Make a HTTP request
        _, code, responseHeaders = http.request{
            url = url,
            method = "GET",
            sink = ltn12.sink.table(body)
        }

    else
        print("Cannot identify the protocol.")
        return nil
    end

    if code ~= 200 then
        print("HTTP request failed with status code: " .. tostring(code))
        return nil
    end


    --Combine response parts
    response.body = table.concat(body)
    response.headers = responseHeaders
    response.code = code

    return response
end

--Write contents to a file, creating it if it doesn't exist
local function writeToFile(filename, contents)
    --Open the contents file (create it if it isnt exists)
    local file, err = io.open(filename, "w")
    if not file then
        print("Cannot open the file: " .. err)
        return false
    end

    --Write contents to file
    local success, writeErr = file:write(contents)

    if not success then
        print("Error writing to file: " .. tostring(writeErr))
        file:close()
        return false
    end

    --Close the file
    file:close()

    print("Contents written successfully.")
    return true
end

--Main function
local function main()
    --Check the arguments
    if not arg[1] or not arg[2] then
        print("Usage: lua LuaScraper.lua <output_file> <url>")
        return
    end

    local url = arg[2]
    local protocol = parseURL(url)
    if not protocol then
        print("Invalid URL protocol.")
        return
    end
    local response = getHTML(url, protocol)

    if not response then
        print("HTTP request failed.")
        return
    end

    --Print HTTP response status
    print("Response status: " .. response.code)

    --Write response to file
    local filename = arg[1]
    if not writeToFile(filename, response.body) then
        print("Failed to write response to file.")
    end

end

main()