/**
 * Class GalleryCreatorFe
 *
 * Provide methods to handle GalleryCreator-output.
 * @copyright  Marko Cupic 2011
 * @author     Marko Cupic <m.cupic@gmx.ch>
 */

"use strict";

// Code by: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
if(!Array.prototype.indexOf)
{
	Array.prototype.indexOf = function(searchE, startIndex)
	{
		var k;
		if( this == null )
			throw new TypeError("this is not defined or null");

		var o = Object(this);
		var len = o.length >>> 0;
		if(len===0)
			return -1;
		var n = +startIndex || 0;
		if( Math.abs(n) === Infinity )
		{
			n = 0;
		}
		if(len<n)
			return -1;
		k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);
		while(k<len)
		{
			if( k in o && o[k] === searchE)
			{
				return k;
			}
			k++;
		}
		return -1;
	};
}

var JSON = JSON || {};

JSON.parse = JSON.parse || function(val)
{
	if( val === "" )
		return '""';
	eval("var jo=" + val + ";");
	return jo;
};

function GalleryCreatorFe()
{
	var s_self = this;
	var m_thumbOpacity = 1.0;
	var m_Xmlhttp = null;
	var m_timeoutHndl = null;
	var m_timeout = 1000;
	var m_currentTime;
	try
	{
		m_Xmlhttp = new XMLHttpRequest();
	}
	catch(e)
	{
		m_Xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}

	this.initThumbSlide = function (el, albumId, countPictures)
	{
		//set some class-vars
		s_self.currentDiv = el;
		s_self.thumb = s_self.find(s_self.currentDiv, 'img.thumb');
		s_self.albumId = albumId;
		s_self.countPictures = countPictures;
		s_self.currentPic = 0;
		s_self.defaultThumbSrc = s_self.thumb.getAttribute('src');
		var currentTime = new Date();
		m_currentTime = currentTime.getTime();
		//add the onmouseout-event
		s_self.bind(s_self.currentDiv,'mouseout', s_self.stopThumbSlide);
		// slide thumbs after a delay of xxx milliseconds
		this.startThumbSlide();
	};

	this.stopThumbSlide = function ()
	{
		m_currentTime = null;
		clearTimeout(m_timeoutHndl);
		m_timeoutHndl = null;
		if( s_self.thumb.getAttribute('src') != s_self.defaultThumbSrc)
		{
			if( window.jQuery )
				jQuery("#" + s_self.thumb.id).fadeTo(m_thumbOpacity);
			else if( window.MooTools )
				document.id(s_self.thumb.id).fade(m_thumbOpacity);
			s_self.thumb.setAttribute('src', s_self.defaultThumbSrc);
		}
		if( window.jQuery )
			jQuery("#" + s_self.thumb.id).fadeTo(m_thumbOpacity);
		else if( window.MooTools )
			document.id(s_self.thumb.id).fade(m_thumbOpacity);
	};

	this.startThumbSlide = function ()
	{
		//next pic
		s_self.currentPic++;
		var lData = 'isAjax=1&thumbSlider=1&AlbumId=' + s_self.albumId + '&limit=' + s_self.currentPic + '&eventId=' + m_currentTime;
		var lUrl = document.URL;
		if( document.URL.search(/(?:\?.*)$/) === -1)
			lUrl += "?";
		else
			lUrl += "&";
		lUrl += lData;

		m_Xmlhttp.onreadystatechange = function()
		{
			if( m_Xmlhttp.readyState !== 4 || m_Xmlhttp.status !== 200 )
				return;
			var l_responseText = "";
			try
			{
				l_responseText = JSON.parse(m_Xmlhttp.responseText);
			}
			catch(e)
			{
				return;
			}
			if (!l_responseText) return;
			if (Number(l_responseText.eventId) != m_currentTime) return;
			if (l_responseText.eventId == null || m_currentTime == null) return;
			if (l_responseText.thumbPath != "" && l_responseText.thumbPath != s_self.thumb.getAttribute('src'))
			{
				var currentTime = new Date();
				var thumb = s_self.thumb;
				thumb.setAttribute('src', l_responseText.thumbPath);
			}
			m_timeoutHndl = setTimeout(s_self.startThumbSlide,m_timeout,m_currentTime);
		};
		m_Xmlhttp.open("GET", lUrl, true);
		m_Xmlhttp.setRequestHeader("X-Requested-With", "XMLHttpRequest");
		m_Xmlhttp.send(null);
		if (s_self.currentPic == s_self.countPictures - 1)
		{
			s_self.currentPic = 0;
		}
	};

	this.bind = function(iObj, iEvType, iFct)
	{
		if( window.addEventListener )
			iObj.addEventListener(iEvType, iFct);
		else
			iObj.attachEvent("on"+iEvType, iFct);
	}

	this.find = function(iObject, iTag)
	{
		var lElm = iTag.split(".");
		if( lElm.length > 1 )
		{
			lElm[0] = lElm[0].toUpperCase();
			var i=0, lLen = iObject.children.length
			for( var i=0; i < lLen; i++ )
			{
				var lNodeName = iObject.children[i].nodeName;
				if( lNodeName == lElm[0] )
				{
					var classes = s_self.classList(iObject.children[i]);
					if( classes.indexOf(lElm[1]) > -1 )
						return iObject.children[i];
				}
				else
				{
					var lTmp = s_self.find(iObject.children[i],iTag);
					if( lTmp !== null )
						return lTmp;
				}
			}
		}
		return null;
	};
	this.classList = function(iObject)
	{
		if( typeof iObject !== "undefined" )
		{
			var lStyle = iObject.getAttribute("class");
			if(lStyle === null)
			{
				lStyle = iObject.getAttributeNode("class");
				if( typeof lStyle !== "undefined" && lStyle !== null )
				{
					lStyle = lStyle.nodeValue;
				}
			}
			if( typeof lStyle !== "undefined" && lStyle !== null )
			{
				return lStyle.replace(/^([\s]*)([.]*)([\s]*)$/g,"$2").split(" ");
			}
		}
	}
};

// global CalleryCreatorFe Object
var objGalleryCreator = new GalleryCreatorFe();

