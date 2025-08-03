# LuaScraper

**LuaScraper** is a lightweight command-line tool built with Lua for downloading the contents of a web page (HTTP or HTTPS) and saving it to a file.


## Features

- Supports both HTTP and HTTPS URLs
- Saves the response body to a specified output file and filepath
- Command-line usage, no browser needed
- Provides error messages for invalid input or network issues

## Used Libraries

- [Lua](https://www.lua.org/) (tested with Lua 5.1+)
- [LuaSocket](https://luarocks.org/modules/luasocket/luasocket)
- [LuaSec](https://luarocks.org/modules/brunoos/luasec) (for HTTPS support)

## Installation

1.  **Download the LuaScraper.lua** the [Releases](https://github.com/YOUR_USERNAME/LuaScraper/releases) page.
2.  **Download the LuaSocket and LuaSec:**

```sh
luarocks install luasocket
```

```sh
luarocks install luasec
```


## Usage

```sh
lua LuaScraper.lua <output_file> <url>
```

- `<output_file>`: The file where the downloaded content will be saved. (you can add a specific filepath)
- `<url>`: The URL to fetch (must start with `http://` or `https://`).

**Example:**

```sh
lua LuaScraper.lua example.html https://example.com
```

## Error Handling

- If the URL is invalid or the protocol is not supported, an error message will be shown.
- If the HTTP request fails, the status code will be displayed.
- If the output file cannot be written, an error message will be shown.

## License

MIT License

© 2025 Emsalettin1. Contributions welcome.