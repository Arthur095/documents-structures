<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="fermeture">
            <sch:assert test=".[not(./text())]">Un élément <sch:name/> ne doit pas contenir de text().</sch:assert>
        </sch:rule>
        <sch:rule context="ouverture">
            <sch:assert test=".[@debut]">Un élément <sch:name/> doit contenir l'attribut @debut.</sch:assert>
            <sch:assert test=".[@fin]">Un élément <sch:name/> doit contenir l'attribut @fin</sch:assert>
            <sch:report test=".[./@saufjour = '']" role="warn">Les points de vente ouverts tous les jours devraient prendre des vacances.</sch:report>
        </sch:rule>
        <sch:rule context="ville">
            <sch:report test="./text()[not(matches(.,'[a-zèéàâîêôûùö]'))]" role="warn">Les noms des villes devraient être tous en majuscule pour la consistance.</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>