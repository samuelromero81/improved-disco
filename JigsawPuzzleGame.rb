require 'gosu'

class JigsawPuzzleGame < Gosu::Window
  def initialize
    super(400, 400)
    self.caption = "Jigsaw Puzzle Game"
    @grid = Array.new(3) { Array.new(3) }
    @order = (0..8).to_a.shuffle
    @selected = nil
    @font = Gosu::Font.new(32)
  end

  def update
    # Nothing to update
  end

  def draw
    3.times do |i|
      3.times do |j|
        idx = @order[i*3+j]
        x, y = j*120+20, i*120+20
        Gosu.draw_rect(x, y, 100, 100, Gosu::Color::GRAY)
        @font.draw_text(idx+1, x+35, y+30, 0)
        draw_border(x, y, idx==@selected)
      end
    end
    if solved?
      @font.draw_text("Solved!", 120, 360, 0, 1.5, 1.5, Gosu::Color::GREEN)
    end
  end

  def draw_border(x, y, highlight)
    color = highlight ? Gosu::Color::YELLOW : Gosu::Color::WHITE
    Gosu.draw_rect(x, y, 100, 5, color)
    Gosu.draw_rect(x, y+95, 100, 5, color)
    Gosu.draw_rect(x, y, 5, 100, color)
    Gosu.draw_rect(x+95, y, 5, 100, color)
  end

  def button_down(id)
    return if solved?
    if id == Gosu::MsLeft
      mx, my = mouse_x.to_i, mouse_y.to_i
      i, j = my/120, mx/120
      idx = i*3+j
      if @selected.nil?
        @selected = @order[idx]
      else
        idx2 = @order.index(@selected)
        @order[idx], @order[idx2] = @order[idx2], @order[idx]
        @selected = nil
      end
    end
  end

  def solved?
    @order == (0..8).to_a
  end
end

JigsawPuzzleGame.new.show