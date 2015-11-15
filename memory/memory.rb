require_relative 'controller.rb'

letters = "abcdefghij"
model = Model.new(letters)
ui = Interface.new(model)

game = Controller.new(model, ui)
game.play
