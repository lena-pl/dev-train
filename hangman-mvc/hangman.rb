require_relative 'controller.rb'
require_relative 'dictionary.rb'

target = Dictionary.random_word
model = Model.new(target)
ui = Interface.new(model)

game = Controller.new(model, ui)
game.play
