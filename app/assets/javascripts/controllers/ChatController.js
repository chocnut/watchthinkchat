'use strict';

angular.module('chatApp').controller('ChatController', function ($scope, $rootScope, $route, $http, $cookies, $location, $filter) {
  var campaign_data;
  var visitor_data = {};
  var chat_data = {};
  var operator_data = {
    uid: $location.search()['o'] || ''
  };
  var video_completed=false;
  var window_focus=false;
  $scope.followup_buttons=[];

  $http({method: 'GET', url: '/api/campaigns/' + $route.current.params.campaignId}).
    success(function (data, status, headers, config) {
      campaign_data = data;
      campaign_data.video_start = 0;
      campaign_data.video_end = 235;

      $scope.campaign_data = campaign_data;
      window.document.title = campaign_data.title;

      if (campaign_data.type === 'youtube') {
        var player;

        var tag = document.createElement('script');
        var title = document.title;
        tag.src = "//www.youtube.com/iframe_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

        window.onYouTubeIframeAPIReady = function () {
          player = new YT.Player('player', {
            videoId: campaign_data.video_id,
            playerVars: {
              autoplay: 0,
              modestbranding: 1,
              rel: 0,
              showinfo: 0,
              iv_load_policy: 3,
              html5: 1,
              start: campaign_data.video_start,
              end: campaign_data.video_end
            },
            events: {
              'onStateChange': onPlayerStateChange
            }
          });
          $('.box, #chat').addClass('paused');
        };
      }

      $scope.followup_buttons.push({
        text: 'No thanks',
        action: 'url',
        value: 'http://cru.org',
        message_active_chat: 'We appreciate the time you gave to watch Falling Plates.Thanks for telling us straight up what you think. There is obviously a reason in your mind right now that causes you to say no to following Jesus. We would love to have a chat about it, if you are interested lets chat on your right hand side--->',
        message_no_chat: 'Thanks for telling us straight up what you think. We really appreciate the time you gave to watch Falling Plates. There is obviously a reason in your mind right now that causes you to say no to following Jesus. '
      });
      $scope.followup_buttons.push({
        text: 'I follow another faith',
        action: 'url',
        value: 'http://gotcx.com/',
        message_active_chat: 'Thanks for taking time to watch #Fallingplates and considering how Jesus desires to bring life to you today. What is it that you find interesting about Jesus? Lets chat on your right hand side ----->',
        message_no_chat: 'Thanks for taking time to watch #Fallingplates and considering how Jesus desires to bring life to you today. We would like to help you understand the uniqueness of Jesus and what we believe he has done for you. If you are interested we have an article here that you could look into and see if Jesus is really is ----> '
      });
      $scope.followup_buttons.push({
        text: 'I am not sure',
        action: 'chat',
        value: '',
        message_active_chat: 'This is a big deal :) and we pumped that u want to take the time to at least consider following Jesus. What is one thing that is attractive to u in following Jesus? What is one thing that makes u hesitant? Love to chat with ya about this stuff in the chat panel on the right :)   ----->',
        message_no_chat: 'This is an important issue and we are glad that you want to take the time to consider following Jesus. Regarding following Jesus, what is one thing that is attractive to you? What is one thing that makes you hesitant? We have a growth adventure that can help you find significance in following Jesus. Find out more "Take the growth adventure" ------>'
      });
      $scope.followup_buttons.push({
        text: 'I want to start',
        action: 'chat',
        value: '',
        message_active_chat: 'Thanks for taking time to watch #FallingPlates and for considering Jesus’s call to follow Him. To desire to start following Jesus is a significant step! Its awesome to see you have that desire! Tell us a bit about what’s up? Luv to chat with ya about this stuff in the chat panel on the right :)   ----->',
        message_no_chat: 'Thanks for taking time to watch #FallingPlates and for considering Jesus’s call to follow Him. To want to begin to start following Jesus is a significant step. We have a growth adventure that can help u grow after u have asked Christ to come into your life. Heres the place for u to get connected with a friend to grow :) '
      });
      $scope.followup_buttons.push({
        text: 'I\'m trying',
        action: 'chat',
        value: '',
        message_active_chat: 'Thanks for watching #FallingPlates and taking time to express how u feel about following Jesus. Sometimes we feel like we will never get there, be good enough or be the person God wants us to be…….which can leave us feeling disappointed or disillusioned. Love to chat with ya about this stuff in the chat panel on the right :)   ----->',
        message_no_chat: 'Thanks for watching #FallingPlates and taking time to express how u feel about following Jesus. Sometimes we feel like we will never get there, be good enough or be the person God wants us to be…….which can leave us feeling disappointed or disillusioned. We have a growth adventure that can help you find real satisfaction and confidence in following Jesus. It will help you understand that the relationship is based on his efforts which are sufficient :) To find out more click here ---->'
      });
      $scope.followup_buttons.push({
        text: 'I\'m following you',
        action: 'chat',
        value: '',
        message_active_chat: 'We are pumped that u are following Jesus! We would love to connect with u and discover how your journey is going and what you think the next steps are to be who He wants you to be? Lets chat over on your right-----> :)',
        message_no_chat: 'We are pumped that u are following Jesus! We know that its not always an easy path, but it’s definitely worth it :)  How ever you feel you are doing today, we are glad He led you here! It’s our goal to help you grow and to help you have influence. We would love to connect you with someone in the adventure of knowing Jesus. You up for the adventure?'
      });
    }).error(function (data, status, headers, config) {

    });

  if (!$cookies.gchat_visitor_id) {
    $http({method: 'POST', url: '/api/visitors'}).
      success(function (data, status, headers, config) {
        visitor_data = data;
        console.log('================ New Visitor Created: ' + data.uid);
        $cookies.gchat_visitor_id = visitor_data.uid;
      }).error(function (data, status, headers, config) {

      });
  } else {
    visitor_data.uid = $cookies.gchat_visitor_id;
  }
  console.log('operator: '+operator_data.uid,'visitor: '+visitor_data.uid);

  $scope.postMessage = function () {
    if($scope.chatMessage==''){
      return;
    }
    var post_data = {
      user_uid: visitor_data.uid,
      message_type: 'user',
      message: $scope.chatMessage
    };
    $scope.chatMessage = '';
    $('.chat-input').attr('placeholder','Sending...');
    $http({method: 'POST', url: '/api/chats/'+chat_data.chat_uid+'/messages', data: post_data}).
      success(function (data, status, headers, config) {
        $('.chat-input').attr('placeholder','Message...');
        $('.conversation').append('<li>      <div class="message text-right">' + post_data.message + '</div>      <div class="timestamp pull-right timestamp-refresh" timestamp="' + Math.round(+new Date()).toString() + '">Just Now</div>      <div class="person">You</div></li>');
        $('.conversation').scrollTop($('.conversation')[0].scrollHeight);
      }).error(function (data, status, headers, config) {
        $('.chat-input').attr('placeholder','Message...');
      });
  };

  $scope.startChat = function(initialMsg){
    if(!video_completed){
      $('#finishVideo').fadeIn().delay(3000).fadeOut();
      return;
    }
    var data = {
      campaign_uid: campaign_data.uid,
      visitor_uid: visitor_data.uid,
      operator_uid: operator_data.uid
    };

    $http({method: 'POST', url: '/api/chats', data: data}).
      success(function (data, status, headers, config) {
        chat_data = data;
        operator_data = data.operator;
        console.log('================ New Chat Created: ' + data.chat_uid);

        $('#chatbox, #after-chat-information-01').fadeIn();

        $('#chatting_with').html('<img src="' + operator_data.profile_pic + '" style="float:left; padding:6px;">   <div class="message">You are chatting with<br>' + operator_data.name + '</div>');
        //console.log('Inital message: '+initialMsg);

        var pusher = new Pusher('249ce47158b276f4d32b');
        pusher.subscribe('visitor_' + visitor_data.uid);
        var channel_chat = pusher.subscribe('chat_'+chat_data.chat_uid);
        channel_chat.bind('event', function (data) {
          if (data.user_uid != visitor_data.uid) {
            if (data.message_type == 'activity') {
              if(data.message == 'challenge'){
                $('.after-chat-challenge').fadeIn();
              }
            } else {
              $('.conversation').append('<li>      <div class="message">' + data.message + '</div>      <div class="timestamp pull-right timestamp-refresh" timestamp="' + Math.round(+new Date()).toString() + '">Just Now</div>      <div class="person">' + operator_data.name + '</div></li>');
              $('.conversation').scrollTop($('.conversation')[0].scrollHeight);

              if (!window_focus) {
                $('#newMsgAlert')[0].play();
              }
            }
          }
        });

        channel_chat.bind('end', function (data) {
          pusher.unsubscribe('chat_'+chat_data.chat_uid);
          $('#chatbox').fadeOut();
          $('#chatEnd').fadeIn();
          $('.conversation').empty();
          //chat_data = {};
        });

        if(initialMsg){
          postActivityMessage(initialMsg);
        }
      }).error(function (data, status, headers, config) {
        alert('Error: ' + (data.error || 'Cannot create new chat.'));
      });
  };

  var launchWebPage = function(url){
    $('#player').hide();
    $('#webpage').show();
    $('#webpage').attr('src',url);
  };

  $scope.buttonClick = function(button){
    $('.after-chat-buttons, .after-chat-title').fadeOut();
    if(button.action == 'url'){
      launchWebPage(button.value);
    }else{
      if(!chat_data.chat_uid){
        $scope.startChat('Visitor has clicked: ' + button.text);
      }else{
        postActivityMessage('Visitor has clicked: ' + button.text);
      }
      $scope.after_chat_message = button.message_active_chat;
    }
  };

  $scope.nextStep = function(step){
    if(step == 2){
      $('#after-chat-information-01, .after-chat-challenge').hide();
      $('#after-chat-information-02').show();
    }else if(step == 3){

      var post_data = {
        EMAIL: $scope.visitor_email,
        RESPONSE: 'I want to start'
      };
      $http({method: 'JSONP',
        url: 'http://gcx.us6.list-manage.com/subscribe/post-json?u=1b47a61580fbf999b866d249a&id=c3b97c030f&EMAIL=' + encodeURIComponent($scope.visitor_email) + '&c=JSON_CALLBACK'
      }).success(function (data, status, headers, config) {
        if (data.result === 'success') {
          $('#after-chat-information-02').hide();
          $('#after-chat-information-03').show();
        } else {
          alert('Error: ' + data.msg);
        }
      }).error(function (data, status, headers, config) {
        alert('Error: Could not connect to mail service.');
        return;
      });
    }else if(step == 4){
      FB.ui({
        method: 'send',
        link: 'http://www.godchat.tv'
      });
      $scope.nextStep(7);
    }else if(step == 5){
      $('#after-chat-information-03').hide();
      $('#after-chat-information-05').show();
    }else if(step == 7){
      $('#after-chat-information-06').show();
      $('#after-chat-information-03, #after-chat-information-05').hide();
    }
  };

  var postActivityMessage = function(message){
    var post_data = {
      user_uid: visitor_data.uid,
      message_type: 'activity',
      message: message
    };
    $http({method: 'POST', url: '/api/chats/'+chat_data.chat_uid+'/messages', data: post_data}).
      success(function (data, status, headers, config) {
      }).error(function (data, status, headers, config) {
      });
  };

  var timeUpdate = setInterval(function () {
    $('.conversation .timestamp-refresh').each(function (i) {
      var origtime = parseInt($(this).attr('timestamp'));
      var unixtime = Math.round(+new Date());

      if ((unixtime - origtime) < 10000) {
        $(this).html('Just Now');
      } else if ((unixtime - origtime) < 60000) {
        $(this).html('about ' + Math.round((unixtime - origtime)/1000).toString() + ' seconds ago');
      } else if ((unixtime - origtime) < 120000) {
        $(this).html('about 1 min ago');
      } else if ((unixtime - origtime) < 240000) {
        $(this).html('about ' + Math.floor(((unixtime - origtime) / 60000)).toString() + ' mins ago');
      }else{
        $(this).html($filter('date')(origtime, 'shortTime'));
        $(this).removeClass('timestamp-refresh');
      }

      //$(this).html(NiceTime(currentval)+'<span>'+currentval+'</span>');
    });
  }, 5000);

  var onPlayerStateChange = function (evt) {
    switch (evt.data) {
      case YT.PlayerState.PLAYING:
        break;
      case YT.PlayerState.ENDED:
        if(!video_completed){
          $('.after-chat-buttons, .after-chat-title').fadeIn(2000);
          $('.box #player').css('opacity','.3');
        }
        video_completed=true;
        break;
      case YT.PlayerState.PAUSED:
        break;
    }
  };

  $(window).focus(function() {
    window_focus=true;
  }).blur(function() {
    window_focus=false;
  });

  FB.init({
    appId      : '555591577865154',
    status     : true,
    xfbml      : true
  });

});