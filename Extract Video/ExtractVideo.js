var ExtractVideo = function() {}

ExtractVideo.prototype = {
  run: function(arguments) {
    const videos = document.querySelectorAll("video")
    let urls = []
    for (const video of videos) {
      urls.push(video.src)
      const sources = video.querySelectorAll("source")
      for (const source of sources) {
          urls.push(source.src)
      }
    }

    arguments.completionFunction({"videos": urls})
  },

  finalize: function(arguments) {
    const success = arguments["success"]
    if (success === "true") {
      window.location = arguments["url"]
    } else if (success == "false") {
      alert(arguments["message"])
    }
  }
};

var ExtensionPreprocessingJS = new ExtractVideo;
