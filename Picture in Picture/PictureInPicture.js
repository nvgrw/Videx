var PictureInPicture = function() {};

PictureInPicture.prototype = {
    run: function(arguments) {
        const video = document.querySelector("video")
        if (video !== null) {
            if (video.webkitSupportsPresentationMode("picture-in-picture")) {
                video.webkitSetPresentationMode("picture-in-picture")
            } else {
                alert("Device does not support picture-in-picture mode")
            }
        } else {
            alert("No video found!")
        }
        
        arguments.completionFunction({})
    }
};
    
var ExtensionPreprocessingJS = new PictureInPicture
