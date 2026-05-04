local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Logger = require(ReplicatedStorage.Logger)

local logger = Logger.new {
	Source = script.Name,
}

print(logger)

logger:info("Hello world!")
logger:warn("Hello world!")
logger:error("Hello world!")
