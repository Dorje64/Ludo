require 'rubygems'
require 'gosu'
require '/home/aviisekh/Desktop/ludo/player.rb'
require '/home/aviisekh/Desktop/ludo/functions.rb'
$id=0
$count=0
$animation_x=0
$ang=500
$winner=false
$message="You won the Game"
$winner_name=""
$winner_color=""

class GameWindow < Gosu::Window 
  def initialize
    super 1462, 1024, false
    self.caption = "Snakes and Ladders"
    @menu_image = Gosu::Image.new(self,"./img/board2.jpg",true)
    @bgimage = Gosu::Image.new(self,"./img/board2.jpg",true)
    @win_bg = Gosu::Image.new(self,"./img/winning_background.png",true)
#   @indicator = Gosu::Image.new(self,"./img/cur815.gif",true)

    @cursor = Gosu::Image.new(self, "./img/cur815.gif", false)     
#   @roll_button = Gosu::Image.new(self, "./img/button.jpg", false)
  
    @turn1 = Gosu::Image.new(self, "./img/player1.png", false)
  
    @turn2 = Gosu::Image.new(self, "./img/player2.png", false)

    @font = Gosu::Font.new(self, Gosu::default_font_name, 400)
    @font1 = Gosu::Font.new(self, Gosu::default_font_name, 100)
    @font2= Gosu::Font.new(self, Gosu::default_font_name, 200)
    @font3= Gosu::Font.new(self, Gosu::default_font_name, 200)
    @font4= Gosu::Font.new(self, Gosu::default_font_name, 200)

    @player1 = Player.new(self,1)  
    @player2 = Player.new(self,0)
  
  end


  def update

    if($winner==true && $ang!=0)
     
      $animation_x +=1
      $ang-=1
    end

  end


  def draw
  			#if ($play==false)
  				@menu_image.draw(0,0,0)
							

			   if ($play==true)
			  	@bgimage.draw(0 ,0, 0)
			# 	@roll_button.draw(1024,924,0)
			    @player1.draw
			    @player2.draw
			    @cursor.draw(mouse_x,mouse_y,0)
			    
			    if($count==0)
			      @turn2.draw(970,188,0)
			      else
			      @turn1.draw(971,0,0)
			    end

				if($winner==true)
			  		@win_bg.draw(0,0,0)
			  		@font1.draw($message,80,400,1)
			  		@font2.draw($winner_name,300,200,1)

					  @font3.draw_rot("GAME",$animation_x,600,1,0)
					  @font4.draw_rot("OVER",1000 - $animation_x,800,1,0)

				end

			 	@font.draw($score1, 1050, 500, 1)
			   # @indicator.draw_rot(1124,800,1,$ang)
			#    puts "jeljfla"
			  end

  end

  



  def button_down(id)
		 if id == Gosu::KbEscape
      	close
    	end 

    	if id == Gosu::MsRight
    		$play=play()
    	end


    if (id == Gosu::MsLeft && $play == true)

    if($winner==false)
      if($count==0)
        roll_dice(@player1)
      
           check(@player1)
            checkForKill(@player2,@player1)
		        @player1.new_position
             $winner = winning(@player1)
       if($winner == false)

       $count=1

     end
      else($count==1)
        roll_dice(@player2)
      
        check(@player2)
 		   checkForKill(@player1,@player2)
        @player2.new_position
          $winner = winning(@player2)

          if($winner==false)

           $count=0
         end
      end

    end 	
end

  end

end


window = GameWindow.new 

window.show