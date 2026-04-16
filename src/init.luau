local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RunService = game:GetService("RunService")

local T = require(ReplicatedStorage.Logger.Packages.T)

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

--[[
	@class Logger

	@prop _enabled boolean --- if false then no logging will be printed to the console
	@prop _prefix boolean --- if true, will include the source name in the log
	@prop _source string --- source to log from, eg: "InventoryService"
	@prop _type boolean --- if true, will include the logging type in the log
	@prop _verbosityLevel number --- lowest logging level to print to the console eg: if the level is 3 (WARN) and a level 1 (DEBUG) log is logged, nothing will get printed
]]
local Logger = {}
Logger.__index = Logger

--[[
	Constructor.

	@param options LoggerOptions --- instanciation options to customize behavior
	@param options.Enabled boolean? --- if false then no logging will be printed to the console
	@param options.Prefix boolean? --- if true, will include the source name in the log
	@param options.Source string --- source to log from, eg: "InventoryService"
	@param options.Type boolean? --- if true, will include the logging type in the log
	@param options.VerbosityLevel number? --- lowest logging level to print to the console eg: if the level is 3 (WARN) and a level 1 (DEBUG) log is logged, nothing will get printed
	@return Logger --- instanciated logger object
]]
function Logger.new(options: LoggerOptions): Logger
	local loggerOptionInterface = T.interface {
		Enabled = T.optional(T.boolean),
		Prefix = T.optional(T.boolean),
		Source = T.string,
		Type = T.optional(T.boolean),
		VerbosityLevel = T.optional(
			T.intersection(T.integer, T.numberConstrained(VerbosityLevel.DEBUG, VerbosityLevel.ERROR))
		),
	}
	assert(loggerOptionInterface(options))

	local self = setmetatable({}, Logger)

	self._enabled = if options.Enabled ~= nil then options.Enabled else DEFAULT_LOGGER_OPTIONS.Enabled
	self._prefix = if options.Prefix ~= nil then options.Prefix else DEFAULT_LOGGER_OPTIONS.Prefix
	self._source = if options.Source ~= nil then options.Source else DEFAULT_LOGGER_OPTIONS.Source
	self._type = if options.Type ~= nil then options.Type else DEFAULT_LOGGER_OPTIONS.Type
	self._verbosityLevel = if options.VerbosityLevel ~= nil
		then options.VerbosityLevel
		else DEFAULT_LOGGER_OPTIONS.VerbosityLevel

	return self
end

--[[
	tostring metamethod.
]]
function Logger.__tostring(self: Logger)
	return string.format("Logger<%s>", self._source)
end

--[[
	Logs a message to the console based on current properties.

	@private
	@param level number --- level of the log
	@param msg string --- message to output
]]
function Logger._log(self: Logger, level: number, msg: string)
	assert(T.intersection(T.integer, T.numberConstrained(VerbosityLevel.DEBUG, VerbosityLevel.ERROR)))
	assert(T.string(msg))

	if (self._enabled == false) or (level < self._verbosityLevel) then
		return
	end

	local log

	if (level == VerbosityLevel.DEBUG) or (level == VerbosityLevel.INFO) then
		log = print
	elseif level == VerbosityLevel.WARN then
		log = warn
	else
		log = error
	end

	local str = ""

	if self._type == true then
		str ..= string.format("[%s] ", VerbosityLevel[level])
	end

	if self._prefix == true then
		str ..= string.format("[%s] ", self._source)
	end

	str ..= msg

	log(str)
end

--[[
	Logs a DEBUG message.

	@param msg string --- message to output
]]
function Logger.debug(self: Logger, msg: string)
	assert(T.string(msg))

	self:_log(VerbosityLevel.DEBUG, msg)
end

--[[
	Logs an INFO message.

	@param msg string --- message to output
]]
function Logger.info(self: Logger, msg: string)
	assert(T.string(msg))

	self:_log(VerbosityLevel.INFO, msg)
end

--[[
	Logs a WARN message.

	@param msg string --- message to output
]]
function Logger.warn(self: Logger, msg: string)
	assert(T.string(msg))

	self:_log(VerbosityLevel.WARN, msg)
end

--[[
	Logs an ERROR message.

	@param msg string --- message to output
]]
function Logger.error(self: Logger, msg: string)
	assert(T.string(msg))

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
