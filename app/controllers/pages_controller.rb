class PagesController < ApplicationController
    def topstories
        @stories = Story.scariest
    end
    
    def randomstories
        @stories = Story.random
    end
end