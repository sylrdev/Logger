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

function Logger._log(self: Logger, level: number, msg: string)
	local log

	if (level == VerbosityLevel.DEBUG) or (level == VerbosityLevel.INFO) then
		log = print
	elseif level == VerbosityLevel.WARN then
		log = warn
	else
		log = error
	end

	local str = ""

	if self._prefix == true then
		str ..= string.format("[%s]", VerbosityLevel[level])
	end
	str ..= string.format("[%s] %s", self._source, msg)

	log(str)
end

function Logger.debug(self: Logger, msg: string)
	self:_log(VerbosityLevel.DEBUG, msg)
end

function Logger.info(self: Logger, msg: string)
	self:_log(VerbosityLevel.INFO, msg)
end

function Logger.warn(self: Logger, msg: string)
	self:_log(VerbosityLevel.WARN, msg)
end

function Logger.error(self: Logger, msg: string)
	self:_log(VerbosityLevel.ERROR, msg)
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
