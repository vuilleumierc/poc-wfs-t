<?xml version="1.0" encoding="UTF-8"?><sld:StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" version="1.0.0">
  <sld:NamedLayer>
    <sld:Name>Default Styler</sld:Name>
    <sld:UserStyle>
      <sld:Name>Default Styler</sld:Name>
      <sld:Title>Points with local svg icon</sld:Title>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <sld:Title>points</sld:Title>
          <sld:PointSymbolizer>
            <sld:Graphic>
              <ExternalGraphic xmlns="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink">
                <OnlineResource xlink:type="simple" xlink:href="icons/fuel.svg" />
                <Format>image/svg+xml</Format>
              </ExternalGraphic>
            </sld:Graphic>
          </sld:PointSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>
