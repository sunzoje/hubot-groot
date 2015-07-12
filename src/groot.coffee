# Description
#   One groot at a time.GIFs.
#
# Configuration:
#   HUBOT_TUMBLR_API_KEY - Tumblr oAuth key
#
# Commands:
#   hubot groot - one groot gif from allgroot
#
# Author:
#   sanjju simha[sunzoje@gmail.com]

module.exports = (robot) ->
  api_key = process.env.HUBOT_TUMBLR_API_KEY
  robot.respond /groot/, (msg) ->
    msg.http('http://api.tumblr.com/v2/blog/allgroot.tumblr.com/posts/photo')
    .query(api_key: api_key)
    .get() (err, res, body) ->
      if err
        msg.send "Groot says: #{err}"
      content = JSON.parse(body)
      if content.meta.status isnt 200
        msg.send "Groot says: #{content.meta.msg}"
      post = msg.random content.response.posts
      msg.send post.caption
      msg.send post.photos[0].original_size.url
