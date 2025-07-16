<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cudl="http://cudl.lib.cam.ac.uk/xtf/" 
    xmlns:json="http://www.w3.org/2005/xpath-functions"
    xmlns:functx="http://www.functx.com"
    xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:teix="http://www.tei-c.org/ns/Examples"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all">
    
    <xsl:output method="html" version="5" indent="no" encoding="UTF-8"/>
    <xsl:strip-space elements="NOTHING"/>
    <xsl:preserve-space elements="*"/>
    
    <xsl:import href="../../../../tei/odds/odd2html.xsl"/>
    <xsl:template match="tei:teiHeader"/>
    
    <xsl:template match="tei:titleStmt/tei:title"><xsl:apply-templates/></xsl:template>
    <xsl:template match="tei:titleStmt/tei:author"/>
    
    <xsl:template match="tei:val|tei:ident" mode="#all">
        <span class="{string-join(('prism-code',local-name()),' ')}">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:att" mode="#all">
        <span class="{string-join(('prism-code',local-name()),' ')}">
            <xsl:text>@</xsl:text>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:gi|tei:tag" mode="#all">
        <span class="{string-join(('prism-code',local-name()),' ')}">
            <code class="language-markup">
                <xsl:text>&lt;</xsl:text>
                <xsl:apply-templates mode="#current"/>
                <xsl:text>&gt;</xsl:text>
            </code>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:eg" mode="#all">
        <xsl:variable name="container_element" select="cudl:determine-output-element-name(.,'div')"/>
        
        <xsl:element name="{$container_element}">
            <xsl:attribute name="class" select="string-join(('prism-code',local-name()),' ')"/>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <!-- Handling of <egXML> elements in the TEI example namespace. -->
    
    <xsl:template match="teix:egXML" priority="999" mode="#all">
        <xsl:variable name="container_element" select="cudl:determine-output-element-name(.,'div')"/>
        
        <xsl:element name="{$container_element}">
            <xsl:attribute name="class" select="string-join(('prism-code','xmlCodeChunk'),' ')"/>
            <pre>
                <code class="language-markup">
                    <xsl:copy-of select="replace(replace(replace(replace(serialize((child::node() | child::text() | child::comment()),map{ 'method':'xml', 'indent': false() }),' xmlns=&quot;http://www.tei-c.org/ns/(Examples|1\.0)&quot;', ''), '\s+xmlns:[a-zA-Z]+=&quot;[^&quot;]+&quot;',''),'\s+([a-zA-Z]+=&quot;[^&quot;]+&quot;)',' $1', 'sm'),'(^\s*&lt;code[^>]+>|&lt;code>\s*$)','')" />
                </code>
            </pre>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*[self::*:span|self::*:div][tokenize(@class,'\s+')=('prism-code')]" priority="999">
        <!-- Override TEI to output structure for better code presentation -->
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:function name="cudl:determine-output-element-name">
        <xsl:param name="node"/>
        <xsl:param name="default"/>
        
        <xsl:choose>
            <xsl:when test="$node[ancestor::tei:p | ancestor::tei:l | ancestor::tei:item]">
                <xsl:text>span</xsl:text>
            </xsl:when>
            <xsl:when test="$node[not(ancestor::tei:p | ancestor::tei:l | ancestor::tei:item)]">
                <xsl:text>div</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$default"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:variable name="autoToc" select="'false'"/>
    
    <xsl:template name="cssHook">
        <!--<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/prism/9000.0.1/themes/prism.min.css"/>-->
        <link rel="stylesheet" type="text/css" href="css/prism.css"/>
        <link rel="stylesheet" type="text/css" href="css/custom.css"/>
    </xsl:template>
    <xsl:template name="jsForOdds"></xsl:template>
    
    <!--<xsl:template name="includeJavascript">
        <script src="https://unpkg.com/prismjs@1.30.0/prism.js"/>
    </xsl:template>-->
    <xsl:param name="cssFile" select="'https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css'"></xsl:param>
    <xsl:param name="cssPrintFile" select="''"></xsl:param>
    <xsl:param name="numberHeadings" select="'false'"></xsl:param>
    <xsl:template name="teiEndHook">
        
        <script src="https://unpkg.com/prismjs@1.30.0/prism.js"/>
    </xsl:template>
    
    <xsl:template match="tei:body">
        <div id="tei" class="container">
            <xsl:apply-templates select="@xml:id | node()"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:elementSpec" mode="weavebody">
        <xsl:variable name="name" select="tei:createSpecName(.)"/>
        <xsl:element namespace="{$outputNS}" name="{$sectionName}">
            <xsl:call-template name="makeSectionHead-elem">
                <xsl:with-param name="id">
                    <xsl:value-of select="concat(tei:createSpecPrefix(.), $name)"/>
                </xsl:with-param>
                <xsl:with-param name="name">
                    <code class="language-markup">
                        <xsl:text>&lt;</xsl:text>
                        <xsl:choose>
                            <xsl:when test="*:content/*:empty">
                                <xsl:value-of select="concat($name,' /')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$name"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>&gt;</xsl:text>
                    </code>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="specHook">
                <xsl:with-param name="name">
                    <xsl:value-of select="$name"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:element namespace="{$outputNS}" name="{$tableName}">
                <xsl:attribute name="{$rendName}">
                    <xsl:text>wovenodd</xsl:text>
                </xsl:attribute>
                <xsl:element namespace="{$outputNS}" name="{$rowName}">
                    <xsl:element namespace="{$outputNS}" name="{$cellName}">
                        <xsl:attribute name="{$colspan}">2</xsl:attribute>
                        <xsl:attribute name="{$rendName}">
                            <xsl:text>wovenodd-col2</xsl:text>
                            <xsl:if test="tei:descOrGlossOutOfDate(.)">
                                <xsl:text> outOfDateTranslation</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:element namespace="{$outputNS}" name="{$hiName}">
                            <xsl:attribute name="{$rendName}">
                                <xsl:text>label</xsl:text>
                            </xsl:attribute>
                            <code class="language-markup">
                                <xsl:text>&lt;</xsl:text>
                                <xsl:choose>
                                    <xsl:when test="*:content/*:empty">
                                        <xsl:value-of select="concat($name,' /')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$name"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:text>&gt;</xsl:text>
                            </code>
                        </xsl:element>
                        <xsl:text> </xsl:text>
                        <xsl:sequence select="tei:makeDescription(., true(), true())"/>
                    </xsl:element>
                </xsl:element>
                <xsl:call-template name="validUntil"/>
                <xsl:call-template name="moduleInfo"/>
                <xsl:variable name="myatts">
                    <a>
                        <xsl:choose>
                            <xsl:when test="not(tei:attList)">
                                <xsl:processing-instruction name="DEBUG"> calling showAttClasses 02 </xsl:processing-instruction>
                                <xsl:call-template name="showAttClasses"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each select="tei:attList">
                                    <xsl:call-template name="displayAttList">
                                        <xsl:with-param name="mode">all</xsl:with-param>
                                    </xsl:call-template>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </a>
                </xsl:variable>
                <xsl:if test="count($myatts/a/*) > 0">
                    <xsl:element namespace="{$outputNS}" name="{$rowName}">
                        <xsl:element namespace="{$outputNS}" name="{$cellName}">
                            <xsl:attribute name="{$rendName}">
                                <xsl:text>wovenodd-col1</xsl:text>
                            </xsl:attribute>
                            <xsl:element namespace="{$outputNS}" name="{$hiName}">
                                <xsl:attribute name="{$rendName}">
                                    <xsl:text>label</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="{$langAttributeName}">
                                    <xsl:value-of select="$documentationLanguage"/>
                                </xsl:attribute>
                                <xsl:sequence select="tei:i18n('Attributes')"/>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element namespace="{$outputNS}" name="{$cellName}">
                            <xsl:attribute name="{$rendName}">
                                <xsl:text>wovenodd-col2</xsl:text>
                            </xsl:attribute>
                            <xsl:choose>
                                <xsl:when test="not(tei:attList)">
                                    <xsl:element namespace="{$outputNS}" name="{$ulName}">
                                        <xsl:attribute name="{$rendName}" select="'attList'"/>
                                        <xsl:processing-instruction name="DEBUG"> calling showAttClasses 03 </xsl:processing-instruction>
                                        <xsl:call-template name="showAttClasses"/>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="tei:attList">
                                        <xsl:call-template name="displayAttList">
                                            <xsl:with-param name="mode">all</xsl:with-param>
                                        </xsl:call-template>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                            <!--
              <xsl:for-each select="$myatts/a">
                <xsl:copy-of select="*|text()"/>
              </xsl:for-each>
              -->
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                <xsl:variable name="memberclasses">
                    <xsl:call-template name="generateModelParents">
                        <xsl:with-param name="showElements">false</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:if test="count($memberclasses/*/*) > 0">
                    <xsl:element namespace="{$outputNS}" name="{$rowName}">
                        <xsl:element namespace="{$outputNS}" name="{$cellName}">
                            <xsl:attribute name="{$rendName}">
                                <xsl:text>wovenodd-col1</xsl:text>
                            </xsl:attribute>
                            <xsl:element namespace="{$outputNS}" name="{$hiName}">
                                <xsl:attribute name="{$rendName}">
                                    <xsl:text>label</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="{$langAttributeName}">
                                    <xsl:value-of select="$documentationLanguage"/>
                                </xsl:attribute>
                                <xsl:sequence select="tei:i18n('Member of')"/>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element namespace="{$outputNS}" name="{$cellName}">
                            <xsl:attribute name="{$rendName}">
                                <xsl:text>wovenodd-col2</xsl:text>
                            </xsl:attribute>
                            <xsl:copy-of select="$memberclasses"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                <xsl:element namespace="{$outputNS}" name="{$rowName}">
                    <xsl:element namespace="{$outputNS}" name="{$cellName}">
                        <xsl:attribute name="{$rendName}">
                            <xsl:text>wovenodd-col1</xsl:text>
                        </xsl:attribute>
                        <xsl:element namespace="{$outputNS}" name="{$hiName}">
                            <xsl:attribute name="{$rendName}">
                                <xsl:text>label</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="{$langAttributeName}">
                                <xsl:value-of select="$documentationLanguage"/>
                            </xsl:attribute>
                            <xsl:sequence select="tei:i18n('Contained by')"/>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element namespace="{$outputNS}" name="{$cellName}">
                        <xsl:attribute name="{$rendName}">
                            <xsl:text>wovenodd-col2</xsl:text>
                        </xsl:attribute>
                        <xsl:call-template name="generateIndirectParents"/>
                    </xsl:element>
                </xsl:element>
                <xsl:element namespace="{$outputNS}" name="{$rowName}">
                    <xsl:element namespace="{$outputNS}" name="{$cellName}">
                        <xsl:attribute name="{$rendName}">
                            <xsl:text>wovenodd-col1</xsl:text>
                        </xsl:attribute>
                        <xsl:element namespace="{$outputNS}" name="{$hiName}">
                            <xsl:attribute name="{$rendName}">
                                <xsl:text>label</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="{$langAttributeName}">
                                <xsl:value-of select="$documentationLanguage"/>
                            </xsl:attribute>
                            <xsl:sequence select="tei:i18n('May contain')"/>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element namespace="{$outputNS}" name="{$cellName}">
                        <xsl:attribute name="{$rendName}">
                            <xsl:text>wovenodd-col2</xsl:text>
                        </xsl:attribute>
                        <xsl:call-template name="generateChildren"/>
                    </xsl:element>
                </xsl:element>
                <xsl:variable name="remarks">
                    <xsl:apply-templates mode="weave" select="tei:remarks"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="string-length($remarks) = 0">
                        <xsl:apply-templates mode="doc" select="tei:remarks[@xml:lang='en']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="$remarks"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates mode="weave" select="tei:exemplum"/>
                <xsl:apply-templates mode="weave" select="tei:constraintSpec"/>
                <xsl:apply-templates mode="weave" select="tei:content"/>
                <xsl:if test="tei:model | tei:modeGrp | tei:modelSequence">
                    <xsl:element namespace="{$outputNS}" name="{$rowName}">
                        <xsl:element namespace="{$outputNS}" name="{$cellName}">
                            <xsl:attribute name="{$rendName}">
                                <xsl:text>wovenodd-col1</xsl:text>
                            </xsl:attribute>
                            <xsl:element namespace="{$outputNS}" name="{$hiName}">
                                <xsl:attribute name="{$rendName}">
                                    <xsl:text>label</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="{$langAttributeName}">
                                    <xsl:value-of select="$documentationLanguage"/>
                                </xsl:attribute>
                                <xsl:sequence select="tei:i18n('ProcessingModel')"/>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element namespace="{$outputNS}" name="{$cellName}">
                            <xsl:attribute name="{$rendName}">
                                <xsl:text>wovenodd-col2</xsl:text>
                            </xsl:attribute>
                            <xsl:call-template name="PMOut">
                                <xsl:with-param name="content"><xsl:apply-templates select="tei:model | tei:modeGrp | tei:modelSequence" mode="PureODD"/></xsl:with-param>
                            </xsl:call-template>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template
        match="
        tei:constraintSpec[parent::tei:schemaSpec or parent::tei:elementSpec or
        parent::tei:classSpec or parent::tei:dataSpec or parent::tei:attDef]"
        mode="weave">
        <xsl:element namespace="{$outputNS}" name="{$rowName}">
            <xsl:element namespace="{$outputNS}" name="{$cellName}">
                <xsl:attribute name="{$rendName}">
                    <xsl:text>wovenodd-col1</xsl:text>
                </xsl:attribute>
                <xsl:element namespace="{$outputNS}" name="{$hiName}">
                    <xsl:attribute name="{$rendName}">
                        <xsl:text>label</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="{$langAttributeName}">
                        <xsl:value-of select="$documentationLanguage"/>
                    </xsl:attribute>
                    <xsl:text>Schematron</xsl:text>
                </xsl:element>
            </xsl:element>
            <xsl:element namespace="{$outputNS}" name="{$cellName}">
                <xsl:attribute name="{$rendName}">
                    <xsl:text>wovenodd-col2</xsl:text>
                    <xsl:if test="tei:descOrGlossOutOfDate(.)">
                        <xsl:text> outOfDateTranslation</xsl:text>
                    </xsl:if>
                </xsl:attribute>
                <xsl:sequence select="tei:makeDescription(., true(), true())"/>
                <xsl:for-each select="tei:constraint">
                    <code class="language-markup">
                        <xsl:copy-of select="replace(replace(replace(serialize((child::node() | child::text() | child::comment()),map{ 'method':'xml', 'indent':true() }),' xmlns=&quot;http://www.tei-c.org/ns/(Examples|1\.0)&quot;', ''), '\s+xmlns:[a-zA-Z]+=&quot;[^&quot;]+&quot;',''),'\s+([a-zA-Z]+=&quot;[^&quot;]+&quot;)',' $1', 'sm')"></xsl:copy-of>
                    </code>
                </xsl:for-each>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:elementSpec/tei:content" mode="weave">
        <xsl:variable name="name" select="tei:createSpecName(..)"/>
        <xsl:element namespace="{$outputNS}" name="{$rowName}">
            <xsl:element namespace="{$outputNS}" name="{$cellName}">
                <xsl:attribute name="{$rendName}">
                    <xsl:text>wovenodd-col1</xsl:text>
                </xsl:attribute>
                <xsl:element namespace="{$outputNS}" name="{$hiName}">
                    <xsl:attribute name="{$rendName}">
                        <xsl:text>label</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="{$langAttributeName}">
                        <xsl:value-of select="$documentationLanguage"/>
                    </xsl:attribute>
                    <xsl:sequence select="tei:i18n('ContentModel')"/>
                </xsl:element>
            </xsl:element>
            <xsl:element namespace="{$outputNS}" name="{$cellName}">
                <xsl:attribute name="{$rendName}">
                    <xsl:text>wovenodd-col2</xsl:text>
                </xsl:attribute>
                <code class="language-markup">
                    <xsl:variable name="processed_content_odd" as="item()*">
                        <xsl:apply-templates select="." mode="PureODD"/>
                    </xsl:variable>
                    <xsl:copy-of select="replace(replace(replace(replace(serialize((child::node() | child::text() | child::comment()),map{ 'method':'xml', 'indent':true() }),' xmlns=&quot;http://www.tei-c.org/ns/(Examples|1\.0)&quot;', ''), '\s+xmlns:[a-zA-Z]+=&quot;[^&quot;]+&quot;',''),' +([a-zA-Z]+=&quot;[^&quot;]+&quot;)',' $1'),'\s+([a-zA-Z]+=&quot;[^&quot;]+&quot;)',' $1', 'sm')" xml:space="preserve"/>
                </code>
                <xsl:for-each select="tei:valList[@type='closed']">
                    <xsl:sequence select="tei:i18n('Legal values are')"/>
                    <xsl:text>:</xsl:text>
                    <xsl:call-template name="valListItems"/>
                </xsl:for-each>
            </xsl:element>
        </xsl:element>
        <xsl:element namespace="{$outputNS}" name="{$rowName}">
            <xsl:element namespace="{$outputNS}" name="{$cellName}">
                <xsl:attribute name="{$rendName}">
                    <xsl:text>wovenodd-col1</xsl:text>
                </xsl:attribute>
                <xsl:element namespace="{$outputNS}" name="{$hiName}">
                    <xsl:attribute name="{$rendName}">
                        <xsl:text>label</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="{$langAttributeName}">
                        <xsl:value-of select="$documentationLanguage"/>
                    </xsl:attribute>
                    <xsl:sequence select="tei:i18n('Schema Declaration')"/>
                </xsl:element>
            </xsl:element>
            <xsl:element namespace="{$outputNS}" name="{$cellName}">
                <xsl:attribute name="{$rendName}">
                    <xsl:text>wovenodd-col2</xsl:text>
                </xsl:attribute>
                <xsl:variable name="content">
                    <Wrapper>
                        <rng:element name="{$name}">
                            <xsl:if test="not(key('SCHEMASPECS',1))">
                                <xsl:if test="$autoGlobal='true'">
                                    <rng:ref name="att.global.attributes"/>
                                </xsl:if>
                                <xsl:for-each select="..">
                                    <xsl:call-template name="showClassAtts"/>
                                </xsl:for-each>
                            </xsl:if>
                            <!--
                  We want the attributes here as the result of
                  tangling our sibling <attList>(s). However, we do
                  not want the <constraintSpec>s to be processed. See
                  https://github.com/TEIC/Stylesheets/issues/488
                  and
                  https://github.com/TEIC/TEI/issues/2115.
                  To do this, we pass a tunneled parameter to the tangle
                  mode templates so that they can suppress the constraintSpecs
                  when rendering the element content model.
                  —Syd, Martin, Nick, and Martina, 2021-02-25
              -->
                            <xsl:apply-templates mode="tangle" select="../tei:attList">
                                <xsl:with-param as="xs:boolean" name="includeConstraints" tunnel="yes" select="false()"/>
                            </xsl:apply-templates>
                            <xsl:for-each select="..">
                                <xsl:call-template name="defineContent"/>
                            </xsl:for-each>
                        </rng:element>
                    </Wrapper>
                </xsl:variable>
                <xsl:call-template name="schemaOut">
                    <xsl:with-param name="grammar"/>
                    <xsl:with-param name="content" select="$content"/>
                </xsl:call-template>
                <xsl:for-each select="tei:valList[@type = 'closed']">
                    <xsl:sequence select="tei:i18n('Legal values are')"/>
                    <xsl:text>:</xsl:text>
                    <xsl:call-template name="valListItems"/>
                </xsl:for-each>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template name="makeSectionHead-elem">
        <xsl:param name="name"/>
        <xsl:param name="id"/>
        <h3>
            <xsl:attribute name="class">
                <xsl:text>oddSpec</xsl:text>
                <xsl:if test="@status">
                    <xsl:text> status_</xsl:text>
                    <xsl:value-of select="@status"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:call-template name="makeAnchor">
                <xsl:with-param name="name">
                    <xsl:value-of select="$id"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:copy-of select="$name"/>
            <xsl:if test="@ns">
                [<xsl:value-of select="@ns"/>]
            </xsl:if>
        </h3>
    </xsl:template>
    
    <xsl:template name="stdheader">
        <xsl:param name="title" select="''"/>
    </xsl:template>
    
    <xsl:template match="tei:head" priority="99">
        <xsl:variable name="level">
            <xsl:choose>
                <xsl:when test="/tei:TEI/@type = 'site'">
                    <xsl:value-of select="count(ancestor::tei:div) + 1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="2"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="h{$level}">
            <xsl:if test="@xml:id">
                <xsl:attribute name="id" select="@xml:id"/>
            </xsl:if>
            <xsl:call-template name="add_class">
                <xsl:with-param name="tokens" select="string-join((@rendition, 'my-3', tokenize(@rend, '\s+')[not(starts-with(., 'indent'))][1]), ' ')"/>
            </xsl:call-template>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:hi" priority="9">
        <xsl:variable name="rend_details" as="item()">
            <xsl:call-template name="render_inline">
                <xsl:with-param name="tokens" select="(@rend, local-name()[not(.='hi')])"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:element name="{string($rend_details//text())}">
            <xsl:if test="$rend_details//@classes !=''">
                <xsl:attribute name="class" select="$rend_details//@classes"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="render_inline">
        <xsl:param name="tokens"/>
        
        <xsl:variable name="tokenized_items" select="tokenize(normalize-space(string-join($tokens,' ')),'\s+')"/>
        <xsl:variable name="token_map">
            <list>
                <item n="bold">strong</item>
                <item n="doubleUnderline">em</item>
                <item n="italic">em</item>
                <item n="subscript" suppressClass="yes">sub</item>
                <item n="superscript" suppressClass="yes">sup</item>
                <item n="underline">em</item>
            </list>
        </xsl:variable>
        
        <xsl:variable name="results" as="item()">
            <item classes="{$tokenized_items[not(.=$token_map//*:item[@suppressClass='yes']/@n)]}">
                <xsl:value-of select="($token_map//*:item[@n=$tokenized_items[1]], 'span')[.!=''][1]"/>
            </item>
        </xsl:variable>
        
        <xsl:copy-of select="$results"/>
    </xsl:template>
    
    <xsl:template name="add_class" as="item()*">
        <xsl:param name="tokens"/>
        <xsl:param name="default"/>
        
        <xsl:variable name="tk" select="tokenize(normalize-space(string-join($tokens,' ')),'\s+')"/>
        
        <xsl:variable name="distinct_tokens">
            <xsl:choose>
                <xsl:when test="count(($tk)[not(.='')])&gt;0">
                    <xsl:copy-of select="$tk"/>
                </xsl:when>
                <xsl:when test="$default[not(.='')]">
                    <xsl:copy-of select="$default"/>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="$distinct_tokens[not(.='')]">
            <xsl:attribute name="class">
                <xsl:value-of select="string-join(functx:sort($distinct_tokens),' ')"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <xsl:function name="functx:sort" as="item()*">
        <xsl:param name="seq" as="item()*"/>
        
        <xsl:for-each select="$seq">
            <xsl:sort select="."/>
            <xsl:copy-of select="."/>
        </xsl:for-each>
        
    </xsl:function>
</xsl:stylesheet>