# Description
#   A Hubot script to persist hubot's brain using text-file
#
# Configuration:
#   HUBOT_FILE_BRAIN_PATH
#
# Commands:
#   None
#
# Author:
#   bouzuya <m@bouzuya.net>

fs = require 'fs'

config =
  path: '/var/hubot/brain.json'

if process.env.HUBOT_FILE_BRAIN_PATH
  config.path = process.env.HUBOT_FILE_BRAIN_PATH

module.exports = (robot) ->

  robot.brain.setAutoSave false

  load = ->
    if fs.existsSync config.path
      data = JSON.parse fs.readFileSync config.path, 'utf-8'
      robot.brain.mergeData data
    robot.brain.setAutoSave true

  robot.brain.on 'save', (data) ->
    fs.writeFileSync config.path, JSON.stringify(data), 'utf-8'

  load()

