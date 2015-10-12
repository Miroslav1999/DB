<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
      <html>
        <style>
          table {
            font-size: 15px;
            text-align: center;
          } 
        </style>
        <body>
          <table border="1">
            <tr>
              <td>Name</td>
              <td>Artist</td>
              <td>Year</td>
              <td>Producer</td>
              <td>Price</td>
              <td>Songs</td>
            </tr>
            <xsl:for-each select="catalog/album">
              <tr>
                <td>
                  <xsl:value-of select="name"/>
                </td>
                <td>
                  <xsl:value-of select="artist"/>
                </td>
                <td>
                  <xsl:value-of select="year"/>
                </td>
                <td>
                  <xsl:value-of select="producer"/>
                </td>
                <td>
                  <xsl:value-of select="price"/>
                </td>
                <td>
                  <xsl:for-each select="songs/song">
                    <tr>
                      <td>
                        <xsl:value-of select="title"/>
                      </td>
                      <td>
                        <xsl:value-of select="duration"/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </td>
              </tr>
            </xsl:for-each>
          </table>
        </body>
      </html>
    </xsl:template>
</xsl:stylesheet>
