
extends Node

class Profile:
	var ID		#universal int ID for each profile
	var name	#name which shows up on the profile selection panel
	var epoch	#unix time at which the profile was created
	
	var settings
	var progress	#a list of Events that flag user has completed
					#(used to unlock the world upon restoration)

	var playerStats = {}	#used to store player stats upon game save/restore
	
	
	func _init(ID,name,epoch=null, settings=null, progress = [],\
				playerStats = {}):
		self.ID = ID
		self.name = name
		if epoch == null:
			self.epoch = OS.get_unix_time()
		else:	self.epoch = epoch
		
		if settings == null:
			self.settings = ConfigFile.new()
		self.progress = progress
		self.playerStats = playerStats

	func add_progress(this):
		if this in self.progress:
			OS.alert("I'm trying to add Progress when it should already be there! \n WTF!?!?!")
		else:
			self.progress.append(this)


