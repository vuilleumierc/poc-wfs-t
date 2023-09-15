<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" 
 xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
 xmlns="http://www.opengis.net/sld" 
 xmlns:ogc="http://www.opengis.net/ogc" 
 xmlns:xlink="http://www.w3.org/1999/xlink" 
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <NamedLayer>
    <Name>color_line</Name>
    <UserStyle>
      <Title>Line with color</Title>
      <FeatureTypeStyle>
        <Rule>
          <Name>rule1</Name>
          <Title>Line with color</Title>
          <Abstract>A solid line with a 3 pixel width</Abstract>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">
                <ogc:PropertyName>color</ogc:PropertyName>
              </CssParameter>
              <CssParameter name="stroke-width">3</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
