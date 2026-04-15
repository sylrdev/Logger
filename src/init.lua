local Logger = {}
Logger.__index = Logger

function Logger.new(options: LoggerOptions)
	local self = setmetatable({}, Logger)

	return self
end

type LoggerOptions = {}

return Logger
