//
//  glMapViewDelegate.m
//  GlasAanHuis
//
//  Created by Nanne on 01-06-14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glMapViewDelegate.h"
#import <MapKit/MapKit.h>

@implementation glMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        MKPolygonRenderer* aRenderer = [[MKPolygonRenderer alloc] initWithPolygon:(MKPolygon*)overlay];
        
        CGFloat redValue = ceilf((1.0f - fmaxf(0.5f, self.percentage)) * (1.0f/0.5f));
        CGFloat greenValue = ceilf(fminf(0.5f, self.percentage) * (1.0f/0.5f));
        
        UIColor *myColor = [UIColor colorWithRed:redValue green:greenValue blue:0 alpha:1.0f];
        
        aRenderer.fillColor = [myColor colorWithAlphaComponent:0.2];
        aRenderer.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        aRenderer.lineWidth = 3;
        
        return aRenderer;
    }
    
    return nil;
}
@end
