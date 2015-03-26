App.addChild('ShowProjects', _.extend({
  el: 'body[data-action="index"][data-controller-name="projects"]',


  activate: function(){
    this.$loader = this.$("#loading img");
    this.$loaderDiv = this.$("#loading");
    this.$results = this.$(".results");
    this.path = this.$("#explore_results").data('projects-path');


    this.setInitialFilter();
    this.setupScroll();

    if(window.location.hash == ''){
      this.fetchPage();

    }
  },



  followRoute: function(route, name, params){
    this.filter = {};
    if(params.length > 0){
      this.filter[name] = params[0];
    }
    else{
      this.filter[name] = true;
    }
    this.firstPage();
    this.fetchPage();
    if(this.parent && this.parent.$search.length > 0){
      this.parent.$search.val('');
    }
    this.selectLink();
  },

  setInitialFilter: function(){
      this.filter = {
        recommended: true,
        // not_expired: true
      };
  },

}, Skull.InfiniteScroll));



App.addChild('Project', _.extend({
  el: 'body[data-action="show"][data-controller-name="projects"]',

  events: {
    'click #toggle_warning a' : 'toggleWarning',
    'click a#embed_link' : 'toggleEmbed'
  },

  activate: function(){
    this.$warning = this.$('#project_warning_text');
    this.$embed= this.$('#project_embed');
    this.route('about');
    this.route('posts');
    this.route('contributions');
    this.route('comments');
    this.route('edit');
    this.route('reports');
    this.route('metrics');
  },

  toggleWarning: function(){
    this.$warning.slideToggle('slow');
    return false;
  },

  toggleEmbed: function(){
    this.loadEmbed();
    this.$embed.slideToggle('slow');
    return false;
  },

  followRoute: function(name){
    var $tab = this.$('nav a[href="' + window.location.hash + '"]');
    if($tab.length > 0){
      this.onTabClick({ currentTarget: $tab });
      var tabs = ['metrics_link'];

      if($.inArray($tab.prop('id'), tabs) !== -1) {
        $('#project-sidebar').hide();
      } else {
        $('#project-sidebar').show();
      }
    }
  },

  loadEmbed: function() {
    var that = this;

    if(this.$embed.is(':empty')) {
      $.get(this.$embed.data('path')).success(function(data){
        that.$embed.html(data);
      });
    }
  }
}, Skull.Tabs));
