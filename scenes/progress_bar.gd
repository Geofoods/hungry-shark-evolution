extends ProgressBar

func _process(delta):
	# Update ProgressBar value from global oxygen
	value = UserInterface.oxygen
	UserInterface.oxygen -= 0.01
