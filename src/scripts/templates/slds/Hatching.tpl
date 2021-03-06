<StyledLayerDescriptor version="1.0.0">
  <NamedLayer>
  <Name><%=layer%></Name>
  <UserStyle>
    <Title><%=layer%></Title>
      <FeatureTypeStyle>
        <Rule>
          <PolygonSymbolizer>
             <Fill>
               <CssParameter name="fill">#ffffff</CssParameter>
             </Fill>
             <Stroke>
               <CssParameter name="stroke">#000000</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
           </PolygonSymbolizer>
           <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#ff0000</CssParameter>
              <GraphicFill>
                <Graphic>
                  <Mark>
                    <WellKnownName>x</WellKnownName>
                    <Fill>
                      <CssParameter name="fill">#<%=colour%></CssParameter>
                    </Fill>
                  </Mark>
                  <Size>8.0</Size>
                </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>