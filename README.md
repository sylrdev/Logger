# LOGGER

Logger is a simple logger utility class to ease the pain of repetitive print formatting.
Works exclusively on Roblox.

## API

### .new()
```lua
Logger.new(options) --> [Logger]
    -- options [LoggerOptions] --- instanciation options to customize behavior
```
Logger constructor.

### LoggerOptions
```lua
options.Enabled -- [boolean?] --- if false then no logging will be printed to the console
options.Prefix -- [boolean?] --- if true, will include the source name in the log
options.Source -- [string] --- source to log from, eg: "InventoryService"
options.Type -- [boolean]? --- if true, will include the logging type in the log
options.VerbosityLevel -- [number?] --- lowest logging level to print to the console eg: if the level is 3 (WARN) and a level 1 (DEBUG) log is logged, nothing will get printed
```

### :info()
```lua
logger:info(msg)
    -- msg [string] --- message to log
```
Outputs an INFO level message.

### :warn()
```lua
logger:warn(msg)
    -- msg [string] --- message to log
```
Outputs a WARN level message.

### :error()
```lua
logger:error(msg)
    -- msg [string] --- message to log
```
Outputs an ERROR level message.

## INSTALLATION

You can use Logger in your project with Wally.
```toml
Logger = "sylrdev/logger@0.2.0"
```
[Package link](https://wally.run/package/sylrdev/logger)

### TODO
- Docs
