-- create role with select privilage to the prevoius view ((Not Onlie))
CREATE ROLE BookRole;                                    
GRANT SELECT ON vBookStatus TO BookRole;