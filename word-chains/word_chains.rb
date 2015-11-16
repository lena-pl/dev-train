require_relative 'controller.rb'
require_relative 'dictionary.rb'

dictionary = Dictionary.make
model = Model.new(dictionary)
ui = Interface.new(model)

game = Controller.new(model, ui)
game.play
