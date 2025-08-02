# LuaScraper

LuaScraper is a simple command-line tool written in Lua for downloading the contents of a web page (HTTP or HTTPS) and saving it to a file.

## Features

- Supports both HTTP and HTTPS URLs
- Saves the response body to a specified output file
- Provides error messages for invalid input or network issues

## Used Libraries

- [Lua](https://www.lua.org/) (tested with Lua 5.1+)
- [LuaSocket](https://luarocks.org/modules/luasocket/luasocket)
- [LuaSec](https://luarocks.org/modules/brunoos/luasec) (for HTTPS support)

## Installation

Download the pre-built executable for your platform.  
(Optional) Add it to your PATH to run it from anywhere.

## Usage

```sh
LuaScraper <output_file> <url>
```

- `<output_file>`: The file where the downloaded content will be saved.
- `<url>`: The URL to fetch (must start with `http://` or `https://`).

**Example:**

```sh
LuaScraper example.html https://example.com
```

## Error Handling

- If the URL is invalid or the protocol is not supported, an error message will be shown.
- If the HTTP request fails, the status code will be displayed.
- If the output file cannot be written, an error message will be shown.

## License

MIT License
