--import libraries
local https = require("ssl.https")
local http = require("socket.http")
local ltn12 = require("ltn12")

--Parsing URL
local function parseURL(url)
    --Looking for protocol
    local start_pos, end_pos = string.find(url, "://")
    if start_pos then
        local result = string.sub(url, 1, start_pos - 1)
        return result

    else
        print("Cannot identify the protocol.")
        return nil
    end
end

--HTTP GET function
local function httpGet(url, protocol)
    local response = {}
    local body = {}
    local code, responseHeaders

    if protocol == "https" then
        --make HTTPS request
        _, code, responseHeaders = https.request{
            url = url,
            method = "GET",
            sink = ltn12.sink.table(body),
        }

    elseif protocol == "http" then
        --make HTTP request
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
        error("HTTP request failed with status code: " .. code)
        return nil
    end


    --combine response parts
    response.body = table.concat(body)
    response.headers = responseHeaders
    response.code = code

    return response
end

local function writeToHTML(contents)
    --open the contents file (create it if it isnt there)
    local file, err = io.open("index.html", "w")
    if not file then
        print("Cannot open file: " .. err)
        return false
    end

    local success, writeErr = file:write(contents)
    if not success then
        print("Error writing to the file: " .. tostring(writeErr))
        file:close()
        return false
    end

    file:close()
    print("Contents wrote successfully.")
    return true
end

local function main()
    local url = "https://google.com"
    local response = httpGet(url, parseURL(url))

    if not response then
        print("HTTP request failed.")
        return
    end

    --print HTTP response status
    print("Response status: " .. response.code)

    --add contents to HTML file
    writeToHTML(response.body)
end

main()