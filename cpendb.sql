PGDMP     '                    z            cpen_db    10.20    10.20                 0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false                       1262    66318    cpen_db    DATABASE     �   CREATE DATABASE cpen_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE cpen_db;
             postgres    false                        2615    66319    dept    SCHEMA        CREATE SCHEMA dept;
    DROP SCHEMA dept;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false                       0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1255    66375    outstanding_fees()    FUNCTION     !  CREATE FUNCTION dept.outstanding_fees() RETURNS TABLE(j json)
    LANGUAGE plpgsql
    AS $$
begin
RETURN QUERY
    SELECT row_to_json(row(CONCAT(st_fname, ' ', st_lname) ,s.st_id, total_fees-amount_paid))
	FROM dept.student s INNER JOIN dept.fee_payment f
	ON s.st_id = f.st_id;
end;
$$;
 '   DROP FUNCTION dept.outstanding_fees();
       dept       postgres    false    1    5            �            1259    66320    course    TABLE     �   CREATE TABLE dept.course (
    course_id character varying(10) NOT NULL,
    course_name character varying(50) NOT NULL,
    credit_hours integer DEFAULT 3
);
    DROP TABLE dept.course;
       dept         postgres    false    5            �            1259    66340    fee_payment    TABLE     �   CREATE TABLE dept.fee_payment (
    total_fees numeric NOT NULL,
    amount_paid numeric DEFAULT 0,
    payment_date date NOT NULL,
    payment_id integer NOT NULL,
    st_id character varying(20) NOT NULL
);
    DROP TABLE dept.fee_payment;
       dept         postgres    false    5            �            1259    66338    fee_payment_payment_id_seq    SEQUENCE     �   CREATE SEQUENCE dept.fee_payment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE dept.fee_payment_payment_id_seq;
       dept       postgres    false    200    5                       0    0    fee_payment_payment_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE dept.fee_payment_payment_id_seq OWNED BY dept.fee_payment.payment_id;
            dept       postgres    false    199            �            1259    66353    lecturer    TABLE       CREATE TABLE dept.lecturer (
    lecturer_id character varying(20) NOT NULL,
    lecturer_fname character varying(50) NOT NULL,
    lecturer_lname character varying(50) NOT NULL,
    lecturer_phone character(50) DEFAULT NULL::bpchar,
    course_id character varying(10)
);
    DROP TABLE dept.lecturer;
       dept         postgres    false    5            �            1259    66326    student    TABLE     <  CREATE TABLE dept.student (
    st_id character varying(20) NOT NULL,
    st_fname character varying(50) NOT NULL,
    st_mname character varying(50) DEFAULT NULL::character varying,
    st_lname character varying(50) NOT NULL,
    st_phone character(50) DEFAULT NULL::bpchar,
    course_id character varying(10)
);
    DROP TABLE dept.student;
       dept         postgres    false    5            �            1259    66364    ta    TABLE     �   CREATE TABLE dept.ta (
    ta_id character varying(20) NOT NULL,
    ta_fname character varying(50) NOT NULL,
    ta_lname character varying(50) NOT NULL,
    ta_phone character(50) DEFAULT NULL::bpchar,
    lecturer_id character varying(20) NOT NULL
);
    DROP TABLE dept.ta;
       dept         postgres    false    5            �
           2604    66344    fee_payment payment_id    DEFAULT     |   ALTER TABLE ONLY dept.fee_payment ALTER COLUMN payment_id SET DEFAULT nextval('dept.fee_payment_payment_id_seq'::regclass);
 C   ALTER TABLE dept.fee_payment ALTER COLUMN payment_id DROP DEFAULT;
       dept       postgres    false    200    199    200                      0    66320    course 
   TABLE DATA               D   COPY dept.course (course_id, course_name, credit_hours) FROM stdin;
    dept       postgres    false    197   n#                 0    66340    fee_payment 
   TABLE DATA               ]   COPY dept.fee_payment (total_fees, amount_paid, payment_date, payment_id, st_id) FROM stdin;
    dept       postgres    false    200   $                 0    66353    lecturer 
   TABLE DATA               h   COPY dept.lecturer (lecturer_id, lecturer_fname, lecturer_lname, lecturer_phone, course_id) FROM stdin;
    dept       postgres    false    201   �$                 0    66326    student 
   TABLE DATA               Y   COPY dept.student (st_id, st_fname, st_mname, st_lname, st_phone, course_id) FROM stdin;
    dept       postgres    false    198   �%                 0    66364    ta 
   TABLE DATA               L   COPY dept.ta (ta_id, ta_fname, ta_lname, ta_phone, lecturer_id) FROM stdin;
    dept       postgres    false    202   �'                  0    0    fee_payment_payment_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('dept.fee_payment_payment_id_seq', 18, true);
            dept       postgres    false    199            �
           2606    66325    course course_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY dept.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);
 :   ALTER TABLE ONLY dept.course DROP CONSTRAINT course_pkey;
       dept         postgres    false    197            �
           2606    66358    lecturer lecturer_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY dept.lecturer
    ADD CONSTRAINT lecturer_pkey PRIMARY KEY (lecturer_id);
 >   ALTER TABLE ONLY dept.lecturer DROP CONSTRAINT lecturer_pkey;
       dept         postgres    false    201            �
           2606    66332    student student_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY dept.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (st_id);
 <   ALTER TABLE ONLY dept.student DROP CONSTRAINT student_pkey;
       dept         postgres    false    198            �
           2606    66369 
   ta ta_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY dept.ta
    ADD CONSTRAINT ta_pkey PRIMARY KEY (ta_id);
 2   ALTER TABLE ONLY dept.ta DROP CONSTRAINT ta_pkey;
       dept         postgres    false    202            �
           2606    66348 "   fee_payment fee_payment_st_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY dept.fee_payment
    ADD CONSTRAINT fee_payment_st_id_fkey FOREIGN KEY (st_id) REFERENCES dept.student(st_id);
 J   ALTER TABLE ONLY dept.fee_payment DROP CONSTRAINT fee_payment_st_id_fkey;
       dept       postgres    false    2699    200    198            �
           2606    66359     lecturer lecturer_course_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY dept.lecturer
    ADD CONSTRAINT lecturer_course_id_fkey FOREIGN KEY (course_id) REFERENCES dept.course(course_id);
 H   ALTER TABLE ONLY dept.lecturer DROP CONSTRAINT lecturer_course_id_fkey;
       dept       postgres    false    197    2697    201            �
           2606    66333    student student_course_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY dept.student
    ADD CONSTRAINT student_course_id_fkey FOREIGN KEY (course_id) REFERENCES dept.course(course_id);
 F   ALTER TABLE ONLY dept.student DROP CONSTRAINT student_course_id_fkey;
       dept       postgres    false    2697    197    198            �
           2606    66370    ta ta_lecturer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY dept.ta
    ADD CONSTRAINT ta_lecturer_id_fkey FOREIGN KEY (lecturer_id) REFERENCES dept.lecturer(lecturer_id);
 >   ALTER TABLE ONLY dept.ta DROP CONSTRAINT ta_lecturer_id_fkey;
       dept       postgres    false    2701    201    202               �   x�%̱
�0�����Ū���Z�`��%�i<�.���u��?=v��<B��+[�p���o�v�O�9��VC;ݪ��,6/9a�C���i�B��,��m&I۠�~�(p��٬�N��Mɲ���٭F�&����R�/�         �   x�u�[�0D��^4<J{��_ǅ�-5Q?���f`d9H���@:�aC�?�M`$:�ڳ�I��=�� 6�6��ɗ�ͣNt�IcE틈�(�aP�>}�+QƵ��L�	�P��!Q��ӽ�3�,@�푟�L�]��^�?�JDʹ�C2 )_f��]p��>k����e���ץl�Q�%S�J�lv��=�ںbTZ=[A^4ٱ��ߙR�W�o[         �   x����
�@���S���긻G�"M�K�e���%·o5����?�B.�J������moE��]-l�m)�3✤V���m�i�fL����a��֐[��r�DͿY,�y/�	�
�q&��7dumlT��5�i�*.�ϩ1#>9�	'�� s�7Qa�`�驔��R-�w�$'�f�} TQ          �  x����r�0���S�	:+$�t�m2m�SO��^� ۚ��`�o�&vzs��3�����h�U:����ʡ���t L����(>-�����)E�=S�n��"����	�����""UD����n�
�|%5]`��������2������xz��u̪��Ti�:�a�A�0g����H��򵫻ة��&*l���S��XN���C�b?��Blծ{�5)��Q�/]�+غ�yd��k5.�^��Vi�l��� ��z���٫���;���bCa3���?�]��,�*g	^�9+0#�Y��� תżW��S}V��Xě�����آ&���^�ʛ
@)3�׾w���{�z&0fJ��y��`e��_D�{O=R��܃V�d
W��*7,&�<��fۅ|�I0�K&����/K�Y[��7:zv�q��Ź�R-��B�����F��P-��i��Ϭ��( w�܊��vm���z7Q����D��s�$� Cy,]         �   x���1�0Eg�� �I�$#�ݐXRԪ"�
E��q8A�G[O�D҆���4w1�%�W�5[���m`!Yv>(Db�CǡKS�z��4��P��v*�����������q���GT�ET���pN�!�5�S��hm�X�v�&cP�X�Ao��}�;���Nk�d)�Uf;�I�,6�WJ}GM�     