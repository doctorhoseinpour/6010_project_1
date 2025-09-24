use Recommendation;
SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);
  
ALTER TABLE `actedIn`
  ADD PRIMARY KEY (`person_id`, `movie_id`);

ALTER TABLE `directed`
  ADD PRIMARY KEY (`person_id`, `movie_id`);

ALTER TABLE `inGenere`
  ADD PRIMARY KEY (`movie_id`, `genre_id`);

ALTER TABLE `ratings`
  ADD PRIMARY KEY (`user_id`, `movie_id`);
  
  
ALTER TABLE `actedIn`
  ADD CONSTRAINT `fk_actedIn_person`
    FOREIGN KEY (`person_id`) REFERENCES `persons`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_actedIn_movie`
    FOREIGN KEY (`movie_id`)  REFERENCES `movies`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `directed`
  ADD CONSTRAINT `fk_directed_person`
    FOREIGN KEY (`person_id`) REFERENCES `persons`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_directed_movie`
    FOREIGN KEY (`movie_id`)  REFERENCES `movies`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE;
    
    

ALTER TABLE `inGenere`
  ADD CONSTRAINT `fk_inGenere_movie`
    FOREIGN KEY (`movie_id`) REFERENCES `movies`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inGenere_genre`
    FOREIGN KEY (`genre_id`) REFERENCES `genre`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE;
    
    
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_ratings_user`
    FOREIGN KEY (`user_id`)  REFERENCES `users`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ratings_movie`
    FOREIGN KEY (`movie_id`) REFERENCES `movies`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE;
    
    
SET FOREIGN_KEY_CHECKS = 1;
