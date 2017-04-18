
extends Node


#Fill this thing up with all kinda crazy
#it needs to be huge, or else!
#but try your very hardest to make it this long..
#(at most)
var messages = [
	"I am a leaf on the wind\nWatch how I soar",
	"Spooky Scary Spooky Scary!",
	"Imma Cuttya!",
	"Don't dig down",
	"Don't stop now",
	"Who on first?",
	"Droppa Mic",
	"Up! Up! Down! Down! Left! Right! Left! Right!",
	"Here to kick ass and do double-jumps",
	"When all eels fall..",
	"Fire Fire!",
	"stop looking at me swan!",
	"lookat me",
	"Agh!\nMy Piles!",
	"In space, no-one can hear you dream",
	"I made this myself!",
	"Let's see you do better",
	"!lookat me",
	"Patterson Trobel!!!",
	"god keep it weird",
	"Don't walk sternly",
	"Cast magic missile",
	"idspispopd",
	"idqfa",
	"But I want grey eyes!",
	"I didn't sign up for this shit!",
	"[Wilhelm Scream]",
	"Go gadget\nGo Gadget go!",
	"A rainbow of love",
	"A box in the sky??",
	"Literally Aweful",
	"Dreadfully bright",
	"It's too blue",
	"Not blue enough",
	"Strong\nBlack\nWoman",
	"look out, mama",
	"smoking kills...\nlasers kill faster",
	"You shart on my heart",
	]
#END OF LIST





func get_motd():
	randomize()
	var limit = messages.size()-1
	var R = int(rand_range(0,limit))
	return messages[R]


