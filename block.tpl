{**
 * plugins/blocks/authorBios/block.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Keyword cloud block plugin
 *
 *}
{* readMoreJS to shrink long bios *}
{literal}
/**
* @app ReadMoreJS
* @desc Breaks the content of an element to the specified number of words
* @version 1.0.0
* @license The MIT License (MIT)
* @author George Raptis | http://georap.gr
*/
(function(c,b,a){var d={};d.helpers={extendObj:function(){for(var g=1,e=arguments.length;g<e;g++){for(var f in arguments[g]){if(arguments[g].hasOwnProperty(f)){if(arguments[g][f]&&arguments[g][f].constructor&&arguments[g][f].constructor===Object){arguments[0][f]=arguments[0][f]||{};this.extendObj(arguments[0][f],arguments[g][f])}else{arguments[0][f]=arguments[g][f]}}}}return arguments[0]}};d.countWords=function(e){return e.split(/\s+/).length};d.generateTrimmed=function(f,e){return f.split(/\s+/).slice(0,e).join(" ")+"..."};d.init=function(w){var f={target:"",numOfWords:50,toggle:true,moreLink:"read more...",lessLink:"read less"};w=d.helpers.extendObj({},f,w);var q=b.querySelectorAll(w.target),t=q.length,v,s,r,u=[],n=[],m,k,e,h,p,g,o;for(m=0;m<t;m++){v=q[m].innerHTML;s=d.generateTrimmed(v,w.numOfWords);r=d.countWords(v);u.push(v);n.push(s);if(w.numOfWords<r-1){q[m].innerHTML=n[m];h=b.createElement("div");h.innerHTML='<a id="rm-more_'+m+'" class="rm-link" style="cursor:pointer;">'+w.moreLink+"</a>";q[m].parentNode.insertBefore(h,q[m].nextSibling)}}p=b.querySelectorAll(".rm-link");for(k=0,e=p.length;k<e;k++){p[k].onclick=function(){g=this.getAttribute("id");o=g.split("_")[1];if(this.getAttribute("data-clicked")!=="true"){q[o].innerHTML=u[o];if(w.toggle!==false){this.innerHTML=w.lessLink;this.setAttribute("data-clicked",true)}else{this.innerHTML=""}}else{q[o].innerHTML=n[o];this.innerHTML=w.moreLink;this.setAttribute("data-clicked",false)}}}};window.$readMoreJS=d}(this,this.document));
{/literal}
<div class="block" id="sidebarRTAuthorBios">
	<span class="blockTitle">
		{if count($article->getAuthors()) gt 1}
			{translate key="plugins.block.authorBios.aboutTheAuthors"}
		{else}
			{translate key="plugins.block.authorBios.aboutTheAuthor"}
		{/if}
	</span>
	{foreach from=$article->getAuthors() item=author name=authors}
	<div class="authorBio">
	<p>
		<em>{$author->getFullName()|escape}</em>
		{if $author->getData('orcid')}<a href="{$author->getData('orcid')|escape}" target="_blank" class="orcid"><img src="{$baseUrl}/plugins/blocks/authorBios/orcid.png" alt="orcid" /></a>{/if}
		{if $author->getUrl()}<br /><a href="{$author->getUrl()|escape:"quotes"}">{$author->getUrl()|escape}</a><br/>{/if}
		{assign var=authorAffiliation value=$author->getLocalizedAffiliation()}
		{if $authorAffiliation}<br/>{$authorAffiliation|escape}{/if}
		{if $author->getCountry()}<br/>{$author->getCountryLocalized()|escape}{/if}
	</p>

	<p>{$author->getLocalizedBiography()|strip_unsafe_html|nl2br}</p>
	</div>
	{if !$smarty.foreach.authors.last}<div class="separator"></div>{/if}

	{/foreach}

{* Customizations to readMoreJS *}
{literal}
<script type="text/javascript">// <![CDATA[
$readMoreJS.init({
  target: '.authorBio',
  numOfWords: 40,
  moreLink: '[ ... ]',
  lessLink: '[ ↵ ]'
});
// ]]></script>
<style>
.rm-link {
  font-size: 1.2em;
}
</style>
{/literal}
</div>
