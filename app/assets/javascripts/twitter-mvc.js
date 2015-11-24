//MODELS

var Twitter = function(args) {
  this.tweets = args.tweets || [];
  this.hashtags = args.hashtags || [];
}

Twitter.prototype.createTweet = function(args){
  var newTweet = new Twitter.Tweet(args, this);
  this.tweets.push(newTweet);
  return newTweet;
}

Twitter.prototype.createHashtag = function(args) {
  var newHashtag = new Twitter.Hashtag(args, this);
  this.hashtags.push(newHashtag);
  return newHashtag;
}

Twitter.prototype.strfyHashtags = function() {
  return this.hashtags.map(function(hashtag) {
    return hashtag.name;
  });
};

Twitter.Tweet = function(args, parentApp) {
  this.username = args.username;
  this.content = args.content;
  this.parentApp = parentApp;
  this.created_at = args.created_at;
  this.hashtags = [];
  this.addTags(args.hashtag_names);
}

Twitter.Tweet.prototype.addTags = function(tagNames) {
  var self = this;
  tagNames.forEach(function(tagName){
    var hashtagLocation = self.parentApp.strfyHashtags().indexOf(tagName);
    if (hashtagLocation != -1) {
      var existingHashtag = self.parentApp.hashtags[hashtagLocation];
      existingHashtag.addTweet(self);
      self.hashtags.push(existingHashtag);
    } else {
      var newHashtag = self.parentApp.createHashtag({name: tagName});
      newHashtag.addTweet(self);
      self.hashtags.push(newHashtag);
    };
  });
};

Twitter.Hashtag = function(args, parentApp){
  this.name = args.name;
  this.tweets = args.tweets || [];
  this.parentApp = parentApp;
};

Twitter.Hashtag.prototype.addTweet = function(tweet) {
  this.tweets.push(tweet);
}

//VIEWS

Twitter.View = function(river, form, controller) {
  this.river = river;
  this.form = form;
  this.ctrl = controller;
  this.setupEventHandling();
};

Twitter.View.prototype.setupEventHandling = function() {
  var self = this;
  this.form.addEventListener('submit', function(e) {
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: '/tweets',
      data: $(this).serialize(),
    }).done(function(response){
    self.ctrl.addTweet()
    })
  })
};

Twitter.View.prototype.fillRiver = function(tweets) {
  var self = this;
  var tweetSource   = $("#tweet-template").html();
  var tweetTemplate = Handlebars.compile(tweetSource);
  tweets.forEach(function(tweetObj) {
    var context = tweetObj;
    var tweetHtml = tweetTemplate(context);
    $(self.river).find('ul').append(tweetHtml);
  });
};

//CONTROLLERS

Twitter.Controller = function(app, view) {
  this.app = app
  this.view = view
}

Twitter.Controller.prototype.loadTweets = function() {
  this.getRecentTweets();
  this.showRecentTweets();
}

Twitter.Controller.prototype.getRecentTweets = function() {
  var self = this;
  $.getJSON('/tweets/recent').done(function(response){
    response.forEach(function(tweetJson){
      self.app.createTweet(tweetJson);
    });
    self.showRecentTweets();
  });
};

Twitter.Controller.prototype.showRecentTweets = function() {
  this.view.fillRiver(this.app.tweets);
}

//RIVER
var app;
$(document).ready(function(){
  app = new Twitter({});
  var view = new Twitter.View(document.getElementById('tweets-container'), document.getElementById('tweet-box'), ctrl)
  var ctrl = new Twitter.Controller(app, view)
  view.ctrl = ctrl;
  ctrl.loadTweets();
})

