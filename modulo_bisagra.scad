/******************************************************/
/* peristaltic extruder for 3d printing     		  */
/* file: modulo_bisagra.scad			 		      */
/* author: luis rodriguez				 	          */
/* version: 0.2						 		          */
/* w3b: tiny.cc/lyu     					 		  */
/* info:				    				 		  */
/******************************************************/
// @todo: - 

// Soporte lateral de cierre para el extrusor
module bisagra_extrusor( altura = 10, radio_exterior = 32 , radio_interior = 24 ,
    ancho_boquilla = 10, largo_boquilla = 20, radio_bisagra = 8,
    diametro_tornillo = 3, radio_tubo = 4 , 
    suavizar_salida_tubo = 5 )
{
    difference(){
        union(){
        // Cuerpo
        difference(){
            difference(){
                union(){
                    // Semi ciculo central
                    difference(){
                        // exterior
                        cylinder( r = radio_exterior, altura, $fn = 100 ); 
                        // interior
                        cylinder(r = radio_interior, altura, $fn = 100 ); 
                    }
                    
                    // boquilla
                    color("red")
                    translate( [ radio_exterior + largo_boquilla / 2 - ( radio_exterior - radio_interior ), 0 , altura / 2 ] ) 
                    cube( [ largo_boquilla , ancho_boquilla * 2 , altura ] , center=true ); 
                }
                // taladro boquilla
                color("blue")
                translate( [ radio_exterior + largo_boquilla / 2 , 0 , altura/2 ] )
                rotate(a=[0,90,0]) { 
                    cylinder( r = radio_tubo , largo_boquilla * 2 , $fn = 100, center = true );
                }
            }
            // Eliminar la parte "mirror" para que darnos con la mitad de la pieza
            color("brown")
            translate( [ - radio_exterior , 0 , 0 ] ) 
            cube( [ ( radio_exterior + altura + largo_boquilla ) * 2, radio_exterior , altura ] ); 
        }
        
        
        // Soporte de la bisagra
        difference(){
            // Cilindro de apoyo entre piezas para el giro ( cuerpo de la bisagra)
            color("green")
            translate( [ - ( radio_exterior + radio_bisagra ) , 0 , 0 ] )
            cylinder(r = radio_bisagra, altura/2, $fn = 100);
            
            // Taladro para el tornillo que hace de eje de la bisagra
            color("black")
            translate( [ - ( radio_exterior + radio_bisagra ) , 0 , altura/4 ] )
            cylinder(r = diametro_tornillo/2, altura, $fn = 100, center = true);
            
            // Taladro para la tuerca
            color("pink")
            translate( [ - ( radio_exterior + radio_bisagra ) , 0 , 0 ] )
            cylinder(r = diametro_tornillo, 3, $fn = 6);
        }
        // Enlace entre cuerpo y soporte de bisagra
        color("lime")
        linear_extrude(height=altura/2)
        polygon( [ [ - ( radio_exterior + radio_bisagra ) ,  - radio_bisagra ] , [ -radio_exterior , 0  ] , 
            [ -radio_exterior * 0.707 , -radio_exterior * 0.707 ] ] , convexity = n);
    }
    
    // Agujerear el camino del tubo atrav�s del cuerpo
    rotate_extrude(convexity = 10)
    translate( [ radio_interior , altura/2 , 0 ] )
    circle( r =  radio_tubo , $fn = 100 );
/*    // toroide para suavizar la salida del tubo de la bomba
    translate( [ radio_interior , 0 , altura/2 ] ) 
    rotate_extrude(convexity = 10)
    translate( [ suavizar_salida_tubo , 0 , 0 ] ) 
    circle( r =  radio_tubo , $fn = 100);*/
}
}