extends ProgressBar

func _process(delta):
	# Update ProgressBar value from global oxygen
	value = UserInterface.oxygen
