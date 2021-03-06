<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes" />

<xsl:strip-space elements="*"/>
<xsl:preserve-space elements="pre"/>

<xsl:template match="/">
  <guide>
    <xsl:apply-templates />
  </guide>
</xsl:template>

<xsl:template match="div[@id='guide']">
  <title><xsl:value-of select="div[@id='mainContent']/h1" /></title>
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="div[@id='sideContent']">
  <xsl:apply-templates select="div[@title='guideAuthor']"/>
  <xsl:apply-templates select="div[@title='guideAbstract']"/>
  <xsl:apply-templates select="div[@title='guideDate']"/>
  <xsl:apply-templates select="//div[@title='guideVersion']"/>
</xsl:template>

<xsl:template match="div[@id='mainContent']">
    <xsl:for-each select="child::*">
      <xsl:if test="@title='guideChapter'">
        <chapter>
        <xsl:for-each select="child::*">
          <xsl:if test="@title='guideSection'">
            <section>
            <xsl:for-each select="child::*">
              <xsl:if test="@title='guideBody'">
                <body>
                    <xsl:apply-templates />
                </body>
              </xsl:if>
              <xsl:if test="@title='guideSectionTitle'">
                <title><xsl:apply-templates /></title>
              </xsl:if>
            </xsl:for-each>
            </section>
          </xsl:if>
          <xsl:if test="@title='guideChapterTitle'">
            <title><xsl:apply-templates /></title>
          </xsl:if>

        </xsl:for-each>
        </chapter>
      </xsl:if>
    </xsl:for-each>
</xsl:template>

<xsl:template match="div[@title='guideAuthor']">
  <xsl:variable name="title">
    <xsl:value-of select="div[@title='guideAuthorTitle']" />
  </xsl:variable>
  <author title="{$title}">
          <xsl:apply-templates select="div[@title='guideAuthorName']" />
    </author>
</xsl:template>

<xsl:template match="div[@title='guideAuthorName']">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="div[@title='guideAuthorTitle']">
</xsl:template>

<xsl:template match="b[@title='guideMailValue']">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="a[@title='guideMail']">
  <xsl:variable name="name">
    <xsl:value-of select="." />
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="string-length(@linkval) &gt; 0">
      <mail link="{@linkval}"><xsl:apply-templates /></mail>
    </xsl:when>
    <xsl:otherwise>
      <mail link="{$name}" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="a[@title='guideLink']">
      <xsl:choose>
        <xsl:when test="string-length(@linkval) &gt; 0">
          <uri link="{@linkval}">
            <xsl:apply-templates />
          </uri>
        </xsl:when>
        <xsl:otherwise>
          <uri>
            <xsl:apply-templates />
          </uri>
        </xsl:otherwise>
      </xsl:choose>
</xsl:template>

<xsl:template match="div[@title='guideDate']">
  <date><xsl:value-of select="div[@title='guideDateValue']" /></date>
</xsl:template>

<xsl:template match="div[@title='guideAbstract']">
  <abstract><xsl:apply-templates select="div[@title='guideAbstractValue']"/></abstract>
</xsl:template>

<xsl:template match="span[@title='guideAbstractValue']">
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="//div[@title='guideVersion']">
  <version><xsl:apply-templates /></version>
</xsl:template>

<xsl:template match="ul[@title='guideUnorderedList']">
    <ul>
      <xsl:apply-templates />
  </ul>
</xsl:template>

<xsl:template match="ol[@title='guideOrderedList']">
    <ol>
      <xsl:apply-templates />
  </ol>
</xsl:template>

<xsl:template match="li">
  <li>
    <xsl:apply-templates />
  </li>
</xsl:template>

<xsl:template match="div[@title='guidePre']">
    <xsl:apply-templates select="div[@title='guidePreCode']" />
</xsl:template>

<xsl:template match="div[@title='guidePreCode']">
    <xsl:variable name="caption">
    <xsl:value-of select="preceding-sibling::div[@title='guidePreHeader']/span[@title='guidePreTitle']" />
  </xsl:variable>
  <pre caption="{$caption}">
      <xsl:for-each select="pre[@title='guideCodeBox']">
          <xsl:apply-templates />
      </xsl:for-each>
  </pre>
</xsl:template>

<xsl:template match="br">
    <xsl:text>&#10;</xsl:text>
</xsl:template>

<xsl:template match="p[@class='ncontent']">
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="span[@title='guideWarning']">
    <warn>
        <xsl:apply-templates select="span[@title='guideWarnValue']"/>
    </warn>
</xsl:template>

<xsl:template match="span[@title='guideWarnValue']">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="span[@title='guideNote']">
    <note>
        <xsl:apply-templates select="span[@title='guideNoteValue']"/>
    </note>
</xsl:template>

<xsl:template match="span[@title='guideNoteValue']">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="span[@title='guideImportant']">
    <impo>
        <xsl:apply-templates select="span[@title='guideImpoValue']"/>
    </impo>
</xsl:template>

<xsl:template match="span[@title='guideImpoValue']">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="p[@title='guideParagraph']">
  <p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="p[@title='guideEpigraph']">
    <xsl:variable name="by">
    <xsl:value-of select="span[@title='guideSignature']" />
  </xsl:variable>
  <p by="{$by}"><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="span[@title='guideComment']">
  <comment>
    <xsl:apply-templates />
  </comment>
</xsl:template>

<xsl:template match="span[@title='guideSub']">
  <sub>
    <xsl:apply-templates />
  </sub>
</xsl:template>

<xsl:template match="span[@title='guideSup']">
  <sup>
    <xsl:apply-templates />
  </sup>
</xsl:template>

<xsl:template match="span[@title='guideStatement']">
  <stmt>
    <xsl:apply-templates />
  </stmt>
</xsl:template>

<xsl:template match="span[@title='guideKeyword']">
  <keyword>
    <xsl:apply-templates />
  </keyword>
</xsl:template>

<xsl:template match="span[@title='guideIdentifier']">
  <ident>
    <xsl:apply-templates />
  </ident>
</xsl:template>

<xsl:template match="span[@title='guideConstant']">
  <const>
    <xsl:apply-templates />
  </const>
</xsl:template>

<xsl:template match="span[@title='guideVariable']">
  <var>
    <xsl:apply-templates />
  </var>
</xsl:template>

<xsl:template match="span[@title='guideEm']">
  <e>
    <xsl:apply-templates />
  </e>
</xsl:template>

<xsl:template match="span[@title='guideBold']">
    <b>
      <xsl:apply-templates />
  </b>
</xsl:template>


<xsl:template match="span[@title='guideCodeInput']">
  <i>
    <xsl:apply-templates />
  </i>
</xsl:template>

<xsl:template match="span[@title='guideCode']">
  <c>
    <xsl:apply-templates />
  </c>
</xsl:template>

<xsl:template match="span[@title='guideCodePath']">
  <path>
    <xsl:apply-templates />
  </path>
</xsl:template>

<xsl:template match="table">
  <table>
    <xsl:apply-templates />
  </table>
</xsl:template>

<xsl:template match="tr">
  <tr>
    <xsl:apply-templates />
  </tr>
</xsl:template>

<xsl:template match="th">
  <th colspan="{@colspan}" rowspan="{@rowspan}" align="{@align}" class="infohead" >
    <xsl:apply-templates />
  </th>
</xsl:template>

<xsl:template match="td">
  <ti colspan="{@colspan}" rowspan="{@rowspan}" align="{@align}" class="tableinfo" >
    <xsl:apply-templates />
  </ti>
</xsl:template>

<xsl:template match="dl">
  <dl>
    <xsl:apply-templates />
  </dl>
</xsl:template>

<xsl:template match="dt">
  <dt>
    <xsl:apply-templates />
  </dt>
</xsl:template>

<xsl:template match="dd">
  <dd>
    <xsl:apply-templates />
  </dd>
</xsl:template>

<xsl:template match="b">
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="div[@title='guidePreHeader']">
</xsl:template>


</xsl:stylesheet>