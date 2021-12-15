-- 1. Selezionare tutti gli studenti nati nel 1990 
SELECT name, surname
FROM students 
WHERE YEAR(date_of_birth) = 1990;

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti
SELECT * 
FROM courses
WHERE cfu > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT *
FROM students 
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) > 30;

-- 4. Selezionare tutti i corsi di laurea magistrale
SELECT *
FROM `degrees`
WHERE `level` LIKE '%magistrale';

-- 5. Da quanti dipartimenti è composta l’università?
SELECT COUNT(id) AS num_of_departments
FROM departments;

-- 6. Quanti sono gli insegnanti che non hanno un numero di telefono?
SELECT COUNT(id) AS teachers_missing_ph_num
FROM teachers
WHERE phone IS NULL;

-- 7. Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(enrolment_date) as enrolment_year, COUNT(id) as students_per_year
FROM students 
GROUP BY YEAR(enrolment_date)
ORDER BY enrolment_year DESC;

-- 8. Calcolare la media dei voti di ogni appello d’esame
SELECT exam_id, AVG(vote) as average_grades
FROM exam_student
GROUP BY exam_id;

-- 9. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT d2.department_id, d.name, COUNT(d.id) as degrees_per_department
FROM `degrees`d2
INNER JOIN departments d 
ON d2.department_id = d.id 
GROUP BY department_id;

-- 10. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT s.id , s.name, s.surname
FROM students s
INNER JOIN `degrees` d 
ON s.degree_id = d.id 
WHERE d.name = 'Corso di Laurea in Economia';

-- 11. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT *
FROM `degrees`
WHERE department_id = 7 AND `level` = 'magistrale';

-- 12. Selezionare tutti i corsi in cui insegna Fulvio Amato
SELECT t.name, t.surname, c.name
FROM course_teacher ct
INNER JOIN courses c 
ON ct.course_id = c.id 
INNER JOIN teachers t 
ON t.id = ct.teacher_id 
WHERE ct.teacher_id = 44;

-- 13. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento
-- in ordine alfabetico per cognome e nome
SELECT s.id, s.name, s.surname, d.name as `degree`, d2.name 
FROM students s
INNER JOIN `degrees` d 
ON s.degree_id = d.id
INNER JOIN departments d2 
ON d.department_id = d2.id
ORDER BY s.surname, s.name;

-- Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami

SELECT s.surname, s.name, COUNT(es.exam_id) AS esami_svolti  
FROM exam_student es  
INNER JOIN students s 
ON es.student_id = s.id 
INNER JOIN exams e 
ON es.exam_id = e.id 
GROUP BY s.id 
ORDER BY s.surname, s.name;


