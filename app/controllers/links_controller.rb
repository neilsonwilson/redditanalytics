class LinksController < ApplicationController
	def common
    return	["a", "able", "about", "above", "across",
"actually", "after", "again", "against", "ago", "ain't", "all", "almost",
"alone", "along", "already", "also", "although", "always", "am", "among",
"an", "and", "another", "any", "anybody", "anyone", "anything", "anywhere",
"are", "area", "areas", "aren't", "around", "as", "ask", "asked", "asking",
"asks", "at", "away", "b", "back", "backed", "backing", "backs", "be",
"became", "because", "become", "becomes", "been", "before", "began", "behind",
"being", "beings", "below", "best", "better", "between", "big", "both", "but",
"by", "c", "came", "can", "cannot", "can't", "case", "cases", "certain",
"certainly", "clear", "clearly", "come", "could", "couldn't", "could've", "d",
"dear", "did", "didn't", "differ", "different", "differently", "do", "does",
"doesn't", "doing", "don", "done", "don't", "down", "downed", "downing",
"downs", "during", "e", "each", "early", "e.g", "either", "else", "end",
"ended", "ending", "ends", "enough", "etc", "even", "evenly", "ever", "every",
"everybody", "everyone", "everything", "everywhere", "f", "far", "few",
"find", "finds", "first", "for", "four", "from", "full", "fully", "further",
"furthered", "furthering", "furthers", "g", "gave", "general", "generally",
"get", "gets", "give", "given", "gives", "go", "going", "good", "got",
"great", "greater", "greatest", "h", "had", "hadn't", "haha", "has", "happen",
"happened", "hasn't", "have", "haven't", "having", "he", "he'd", "he'll",
"her", "here", "here's", "hers", "herself", "he's", "high", "higher",
"highest", "him", "himself", "his", "how", "how'd", "however", "how'll",
"how's", "i", "i'd", "i.e", "if", "i'll", "i'm", "important", "in", "instead",
"interested", "interesting", "into", "is", "isn't", "it", "it'd", "it'll",
"its", "it's", "itself", "i've", "j", "just", "k", "keep", "keeps", "kind",
"knew", "know", "known", "knows", "l", "large", "largely", "last", "later",
"latest", "least", "less", "let", "lets", "let's", "like", "likely", "long",
"longer", "longest", "looked", "looks", "lot", "m", "made", "make", "making",
"many", "may", "maybe", "me", "might", "mightn't", "might've", "more", "most",
"mostly", "mr", "mrs", "much", "must", "mustn't", "must've", "my", "myself",
"n", "necessary", "need", "needed", "needing", "needs", "neither", "never",
"new", "newer", "newest", "next", "no", "nobody", "non", "noone", "nor",
"not", "nothing", "now", "nowhere", "o", "of", "off", "often", "oh", "old",
"older", "oldest", "on", "once", "one", "only", "open", "opened", "opening",
"opens", "or", "order", "ordered", "ordering", "orders", "other", "others",
"ought", "our", "ours", "ourselves", "out", "over", "own", "p", "part",
"parted", "parting", "parts", "per", "perhaps", "place", "places", "point",
"pointed", "pointing", "points", "possible", "present", "presented",
"presenting", "presents", "put", "puts", "q", "quite", "r", "rather",
"really", "right", "room", "rooms", "s", "said", "same", "saw", "say", "says",
"second", "seconds", "see", "seem", "seemed", "seeming", "seems", "sees",
"several", "shall", "shan't", "she", "she'd", "she'll", "she's", "should",
"shouldn't", "should've", "show", "showed", "showing", "shows", "side",
"sides", "since", "small", "smaller", "smallest", "so", "some", "somebody",
"someone", "something", "somewhere", "state", "states", "still", "such",
"sure", "t", "take", "taken", "teh", "than", "that", "that'll", "that's",
"the", "their", "theirs", "them", "themselves", "then", "there", "therefore",
"there's", "these", "they", "they'd", "they'll", "they're", "they've",
"thing", "things", "think", "thinks", "this", "those", "though", "three",
"through", "thus", "tis", "to", "today", "together", "too", "took", "toward",
"turn", "turned", "turning", "turns", "twas", "t'was", "two", "u", "under",
"until", "up", "upon", "us", "use", "used", "uses", "using", "v", "very",
"vs", "w", "want", "wanted", "wanting", "wants", "was", "wasn't", "way",
"ways", "we", "we'd", "well", "we'll", "wells", "went", "were", "we're",
"weren't", "we've", "what", "what'd", "what's", "when", "when'd", "when'll",
"when's", "where", "where'd", "where'll", "where's", "whether", "which",
"while", "who", "who'd", "whole", "who'll", "whom", "who's", "whose", "why",
"why'd", "why'll", "why's", "will", "with", "within", "without", "won't",
"works", "would", "wouldn't", "would've", "x", "y", "yes", "yet", "you",
"you'd", "you'll", "young", "younger", "youngest", "your", "you're", "yours",
"yourself", "yourselves", "you've", "z",]
	end 

	def index
		# common = ['person', '1', '2', 'i','love']
		if params[:link] == nil
			return render json: {:error=>'a'}
		end
		@comments = []
		link = params[:link].to_s + ".json"
		@response = HTTParty.get(URI.encode(link))
	    @result = JSON.parse(@response.body)
	    @result[1]["data"]["children"].each do |comment|
	    	@comments.push({:content => comment["data"]["body"] , :children => []})
	    end
	    words = {}
	    @comments.each do |comment|
	    	next unless comment[:content] != nil
	    	comment[:content].strip.downcase.split(/[^\w']+/).group_by(&:to_s).map{ |w| 
	    		words[w[0]] = w[1].count unless common.include? w[0]
	    	} 
	    end
	    @sorted = words.sort_by {|_key, value| value}.reverse
	    # render json: @sorted
	    render :partial => 'index'
	end
	def create
	end

	def update
	end

	def show
	end

	def destroy
	end

 private
    def task_params
      params.require(:link).permit(:url, :issubreddit, :keyword, :created_at, :updated_at)
 end

end
