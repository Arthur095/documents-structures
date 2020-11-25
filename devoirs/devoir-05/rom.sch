<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="TEI">
            <sch:assert test=".[child::teiHeader and child::text]">La racine doit contenir un élément teiHeader et un élément text.</sch:assert>
        </sch:rule>
        <sch:rule abstract="true" id="contient-paragraphe">
            <sch:assert test=".//paragraphe">L'élément <sch:name/> doit toujours contenir un élément paragraphe.</sch:assert>
        </sch:rule>
        <sch:rule context="sp">
            <sch:extends rule="contient-paragraphe"/>
        </sch:rule>
        <sch:rule context="projectDesc">
            <sch:extends rule="contient-paragraphe"/>
        </sch:rule>
    </sch:pattern>
    
    
    <sch:pattern abstract="true" id="div-head">
        <sch:rule context="$element">
            <sch:assert test=".//head">L'élément <sch:name/> doit contenir un élément head. </sch:assert>
            <sch:assert test=".[$attrib > 1 and $attrib2 = 'scene']">L'élément <sch:name/> doit avoir au moins deux éléments scene. </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern is-a="div-head" id="TEI">
        <sch:param name="element" value="div"/>
        <sch:param name="attrib" value="@n"/>
        <sch:param name="attrib2" value="@type"/>
    </sch:pattern>
    
</sch:schema>