--explain explained

-- make sure to run the container with at least 1gb shared memory
-- docker run --name pg —shm-size=1g -e POSTGRES_PASSWORD=postgres —name pg postgres

create table grades (
   id serial primary key, 
   g int,
   name text 
); 

INSERT INTO grades (g, name) 
SELECT 
    random()*100,
    substring(md5(random()::text ),0,floor(random()*31)::int)
FROM generate_series(0, 500);

vacuum (analyze, verbose, full);

explain analyze select id,g from grades where g > 80 and g < 95 order by g;

