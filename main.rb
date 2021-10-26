BEE = [
  [0,2,0],
  [2,0,0],
  [0,1,0],
  [1,0,0],
  [0,1,0],
  [2,0,0],
  [0,1,0],
  [1,0,0],
  [0,1,0],
  [1,0,0],
  [0,1,0],
  [1,0,0],
  [0,1,0],
  [2,0,0],
  [0,1,0],
  [1,0,0],
  [0,2,0],
  [1,0,0],
  [0,1,0],
  [2,0,0],
]

ROTATIONS = [
  [
    [ 1, 0, 0],
    [ 0, 0,-1],
    [ 0, 1, 0],
  ],
  [
    [ 0, 0,-1],
    [ 0, 1, 0],
    [ 1, 0, 0],
  ],
  [
    [ 0,-1, 0],
    [ 1, 0, 0],
    [ 0, 0, 1],
  ],
]

# [0,2,0], -> [X,_,X]
# [2,0,0] [[2,_,0],[0,_,-2],[-2,_,0],[0,_,2]]
# [0,-2,0], -> [X,_,X]
# [2,0,0] [[2,_,0],[0,_,2],[-2,_,0],[0,_,-2]]

require 'matrix'

class Gow
  def initialize(step, chee=nil)
    @step = step
    @chee = chee
  end

  def rotate!(angle, versor)
    i = versor.each_with_index.detect{|e,i| !e.zero?}.last
    vet = Matrix[*@step.map{|s|[s]}]
    rot = Matrix[*ROTATIONS[i]]
    @step = (rot * vet).to_a.flatten

    @chee.rotate!(angle, versor) unless @chee.nil?
  end

  def coords(acc=[0,0,0])
    coord = acc.zip(@step).map { |l| l.inject(:+)}
    [coord, *@chee&.coords(coord)]
  end
end


tail = nil
BEE.reverse.each do |arm|
  tail = Gow.new(arm, tail)
end

puts tail.inspect
puts tail.coords.inspect

tail.rotate!(1, [1,0,0])

puts tail.inspect
puts tail.coords.inspect