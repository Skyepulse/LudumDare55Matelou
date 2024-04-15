extends Label

@onready var text_speed_timer = $'text_speed_timer'
@onready var stay_timer = $'stay_on_screen_timer'

var text_speed = 0.1
var stay_speed = 3

var to_be_written = ""
var written = ""
var currentIndex = -1

var texts=["ma chouquette en chocolat", "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In id erat non pede lacinia auctor. Etiam odio. Aenean massa purus, dignissim sed, pellentesque vitae, mattis eget, ante. In hac habitasse platea dictumst. Suspendisse tempor, libero vel tristique fermentum, augue lorem vehicula mauris, ut vehicula wisi dui vel urna. Nunc non augue. Sed vel felis sed urna convallis vestibulum. Nunc erat ante, pharetra vel, faucibus nec, malesuada ut, augue.
Suspendisse magna enim, pulvinar et, adipiscing non, tempus sed, nibh. Phasellus quis lectus. In sit amet risus sit amet mauris dapibus eleifend. Donec justo neque, scelerisque a, iaculis at, varius at, wisi. Nunc posuere hendrerit nisl.","Oh! une chouquette en chocolat!"]
var text_number = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	text=""
	stay_timer.set_wait_time(stay_speed)
	stay_timer.stop()
	
	text_speed_timer.set_wait_time(text_speed)
	text_speed_timer.start()
	
	to_be_written = texts[0]
	print(to_be_written[0])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_speed_timer_timeout():
	
	if (currentIndex<0):
		currentIndex = 0
		written = to_be_written[currentIndex]
		print(to_be_written[currentIndex])
		text = written
		show()
		text_speed_timer.start()
		return
	
	
	if(currentIndex < len(to_be_written)- 1):
		currentIndex += 1
		written += to_be_written[currentIndex]
		text = written
		text_speed_timer.start()
		return
		
	else:
		text_speed_timer.stop()
		written = ""
		currentIndex = -1
		text_speed_timer.stop()
		stay_timer.start()
		return

func _on_stay_on_screen_timer_timeout():
	text = ""
	hide()
	if text_number<texts.size()-1:
		text_number+=1
		to_be_written=texts[text_number]
	stay_timer.stop()
	text_speed_timer.start()
