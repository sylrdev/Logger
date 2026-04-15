local RunService = game:GetService("RunService")

local VerbosityLevel = {
	DEBUG = 1,
	INFO = 2,
	WARN = 3,
	ERROR = 4,
	[1] = "DEBUG",
	[2] = "INFO",
	[3] = "WARN",
	[4] = "ERROR",
}

local DEFAULT_LOGGER_OPTIONS: LoggerOptions = {
	Enabled = true,
	Prefix = true,
	Source = "SOURCE_NOT_PROVIDED",
	Type = true,
	VerbosityLevel = (function()
		if RunService:IsStudio() == true then
			return VerbosityLevel.DEBUG
		else
			return VerbosityLevel.WARN
		end
	end)(),
}

local Logger = {}
Logger.__index = Logger

function Logger.new(options: LoggerOptions)
	local self = setmetatable({}, Logger)

	self._enabled = options.Enabled or DEFAULT_LOGGER_OPTIONS.Enabled
	self._prefix = options.Prefix or DEFAULT_LOGGER_OPTIONS.Prefix
	self._source = options.Source or DEFAULT_LOGGER_OPTIONS.Source
	self._type = options.Type or DEFAULT_LOGGER_OPTIONS.Type
	self._verbosityLevel = options.VerbosityLevel or DEFAULT_LOGGER_OPTIONS.VerbosityLevel

	return self
end

type LoggerOptions = {
	Enabled: boolean?,
	Prefix: boolean?,
	Source: string,
	Type: boolean?,
	VerbosityLevel: number?,
}
export type Logger = typeof(setmetatable(
	{} :: {
		_enabled: boolean,
		_prefix: boolean,
		_source: string,
		_type: boolean,
		_verbosityLevel: number,
	},
	Logger
))

return Logger
