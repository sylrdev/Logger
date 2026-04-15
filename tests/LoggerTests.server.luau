local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Logger = require(ReplicatedStorage.Logger)

local logger = Logger.new {
	Source = script.Name,
	Prefix = false,
	Type = false,
	Enabled = false,
	VerbosityLevel = 3,
}

logger:debug("Hello world!")
logger:info("Hello world!")
logger:warn("Hello world!")
logger:error("Hello world!")
