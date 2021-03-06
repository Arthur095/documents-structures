xquery version "3.1";

module namespace app="http://exist-db.org/apps/projet/templates";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace functx = "http://www.functx.com";
import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="http://exist-db.org/apps/projet/config" at "config.xqm";
import module namespace kwic = "http://exist-db.org/xquery/kwic" at "resource:org/exist/xquery/lib/kwic.xql";
declare namespace tei="http://www.tei-c.org/ns/1.0";



(:~
 : This is a sample templating function. It will be called by the templating module if
 : it encounters an HTML element with an attribute data-template="app:test" 
 : or class="app:test" (deprecated). The function has to take at least 2 default
 : parameters. Additional parameters will be mapped to matching request or session parameters.
 : 
 : @param $node the HTML node with the attribute which triggered this call
 : @param $model a map containing arbitrary data - used to pass information between template calls
 :)
declare function app:test($node as node(), $model as map(*)) {
    <p>Dummy template output generated by function app:test at {current-dateTime()}. The templating
        function was triggered by the data-template attribute <code>data-template="app:test"</code>.</p>
};


declare function app:XMLtoHTML ($node as node(), $model as map (*), $sxml as xs:string, $sxsl as xs:string) {
let $xml := doc($sxml)
let $xsl := doc($sxsl)
let $params :=
<parameters>
   {for $p in request:get-parameter-names()
    let $val := request:get-parameter($p,())
    where  not($p = ("document","directory","stylesheet"))
    return
       <param name="{$p}"  value="{$val}"/>
   }
</parameters>

return
    transform:transform($xml, $xsl, $params)
};

declare function app:ft_search($node as node(), $model as map (*)) {
    if (request:get-parameter("searchexpr", "") !="") then
    let $searchterm as xs:string := request:get-parameter("searchexpr", "")
    let $field := request:get-parameter("field", "")
    for $hit in collection(concat($config:app-root, '/data/'))//tei:*[name()=$field][ft:query(.,$searchterm)]
    let $document := document-uri(root($hit))
    let $href := concat(app:hrefToDoc($hit), "&amp;searchexpr=", $searchterm)
    return
    if (kwic:summarize($hit, <config width="40" link="{$document}" />) != "") then
    <tr>
        
        <td class="KWIC">{kwic:summarize($hit, <config width="40" link="{$document}" />)}</td>
        <td>{app:getDocName($hit)}</td>
    </tr>
    else
        <d/>
 else
    <div>Veuillez entrer votre recherche.</div>
};

 
declare function app:getDocName($node as node()){
    let $name := functx:substring-after-last(document-uri(root($node)), '/')
    return $name
};


declare function app:hrefToDoc($node as node()){
    let $name := functx:substring-after-last($node, '/')
    let $href := concat('show.html','?document=', app:getDocName($node))
    return $href
};