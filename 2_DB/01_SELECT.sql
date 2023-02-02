/* SELECT (DQL 또는 DML) : 조회
 * 
 * 
 * 데이터를 조회하면 조건에 맞는 행들이 조회됨.
 * 이 떄, 조회된 행들의 집합을 RESULT SET 이라고 한다.
 * RESULT SET은 0개 이상의 행을 포함할 수 있다.
 * 0개인 이유는 조건에 맞는 행이 없을수도 있기 떄문이다.
 *
 */
 
  -- 작성법
-- SELECT 컬럼명 FROM 테이블명;
-- 어떤 테이블의 특정 컬럼을 조회하겠다.
SELECT * FROM EMPLOYEE;
-- '*' : 모든,ALL이란 뜻

--사번,직원이름,휴대전화번호 조회
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

------------------------------------------------

--컬럼 값 산술 연산
--컬럼 값 : 테이블 내 한 칸(== 한 셀)에 작성된 값(DATA)
--EMPLOYEE 테이블에서 모든 사원의 사변,이름,급여,연봉(급여*12) 조회
SELECT EMP_ID, EMP_NAME, SALARY*12 FROM EMPLOYEE;
SELECT EMP_NAME + 10 FROM EMPLOYEE;
--ORA-01722 : 수치가 부적합합니다
-- 산술연산은 숫자만 가능하다

--날짜(DATE) 타입 조회
--EMPLOYEE 테이블에서 이름,입사일,오늘날짜 조회

SELECT EMP_NAME, HIRE_DATE, SYSDATE  FROM EMPLOYEE;
  
  --SYSDATE : 시스템상의 현재시간을 나타내는 상수

-- 현재 시간만 조회하기
SELECT SYSDATE FROM DUAL;
--DUAL(DUmmy tAbLe) 테이블 : 가짜 테이블(임시 조회용 테이블)
--날짜 + 산술연산(+,-)
SELECT SYSDATE  -1,SYSDATE ,SYSDATE +1 FROM DUAL;
--SKFwkDP +/- 연산 시 일 단위로 계산이 진행됨



-------------------------------------

--<컬럼 별칭 지정>
--SELECT 조회 결과의 집한인 RESULT SET에 출력되는 컬럼명을 지정한다
-- AS 생략가능
-- 띄어쓰기가 있는 별칭은 쌍따움표로 묶어주기 + 특수문자도
SELECT SYSDATE  -1 "하루 전",SYSDATE AS 현재시간 ,SYSDATE +1 내일
FROM DUAL;

----------------------------------------------------
 --JAVA에서 리터럴 = 값 자체
 --DB에서 리터럴 = 임의로 지정한 값을 기존 테이블에 존재하는 값처럼 사용하는 것
-- > DB의 리터럴 표기법은 '' 
--> " " 쌍따움표는 특수문자,대소문자,기호 등을 구분하여 나타낼 때 사용하는 표기법
-- 쌍따움표 안에 작성되는 것들이 하나의 단어이다.
SELECT EMP_NAME, SALARY, '원 입니다' FROM EMPLOYEE;


-----------------------------------------------------------------
--DISTINCT : 조회 시 칼럼에 포함된 중복 값을 한 번만 표기
--주의사항 1) DISTINCT 구문은 SELECT 마다 딱 한번씩만 작성 가능
--주의사항 2) DISTINCT 구문은 SELECT 제일 앞에 작성되어야 한다.

SELECT DISTINCT DEPT_CODE, JOB_CODE  FROM EMPLOYEE;

-------------------------------------------------------------
--3. SELECT 절 : SELECT  컬럼명
--1. FROM  절 : FROM 테이블명
--2. WHERE 절(조건절) : WHERE 컬럼명 연산자 값;
--4. ORDER BY 컬럼명 | 별칭 | 컬럼순서 [ASC(오름차순,기본값) | DESC(내림차순)] , [NULLS FIRST | LAST]

--EMPLOYEE 테이블에서 급여가 300만원 초과인 사원조회

SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;

--EMPLOYEE 테이블에서 부서코드 D9인 사원의 사번,이름,부서코드,직급코드 조회
SELECT  EMP_NAME,EMP_ID ,DEPT_CODE ,JOB_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';  --비교연산자 = , 대입연산자 :=

--비교 연산자  >, <. >=, <=, =, !=, <>(같지않다)
--논리 연산자 (AND, OR)
-- EMPLOYEE 테이블에서 급여가 300미만 또는 500이상인 사원의 사번 이름 급여 전화번호 조회

SELECT EMP_NAME, EMP_ID, SALARY,PHONE
FROM EMPLOYEE
WHERE SALARY < 3000000 OR SALARY >= 5000000;

-- EMPLOYEE 테이블에서 급여가 300이상  500미만인 사원의 사번 이름 급여 전화번호 조회

SELECT EMP_NAME, EMP_ID, SALARY,PHONE
FROM EMPLOYEE
WHERE SALARY >= 3000000 AND SALARY < 5000000;

--BETWEEN A AND B : A이상 B이하

SELECT EMP_NAME, EMP_ID, SALARY,PHONE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 6000000;

--NOT 연산자
SELECT EMP_NAME, EMP_ID, SALARY,PHONE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3000000 AND 6000000;

--날짜에 BETWEEN 이용하기
--EMPLOYEE 테이블에서 입사일이 1990-01-01~ 1999-12-31 사이인 직원의 이름 입사일 조회

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '1990-01-01' AND '1999-12-31';

--ex) 1 = '1'
SELECT '같음'
FROM DUAL
WHERE 1 = '1';
------------------------------
--LIKE : ~처럼,~같은
--비교하려는 값이 특정한 패턴을 만족시키면 조회하는 연산자
--[작성법]
--WHERE 컬럼명 LIKE '패턴이 적용된 값'

--LIKE의 패턴을 나타내는 문자(와일드 카드)
--> '%' : 포함
--> '_' : 글자 수
--'%' 에서
--'A%' : A로 시작하는 문자열
--'%A' : A로 끝나는 문자열
--'%A%' : A포함하는 문자열

--'_'에서
--'A_' : A로 시작하는 두글자 문자열
--'___A' : A로 끝나는 네글자 문자열
--'__A__' : 세 번쨰 문자가 A인 다섯글자 문자열
--'_____' : 다섯글자 문자열

--EMPLOYEE테이블에서 성이'전'씨인 사원의 사번 이름 조회
SELECT EMP_NAME,EMP_ID
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전__';   --전% 도 가능(이름이 2~4글자인 사람도 조회가능하기 떄문에 이게 더 좋음)

--EMPLOYEE 테이블에서 전화번호가 010으로 시작하지 않는 사원의 사번 이름 전화번호 조회
SELECT EMP_NAME, EMP_ID, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '%010%';

--sun_di@or.kr
--EMPLOYEE 테이블에서 이메일의 _앞에 글자가 세글자인 사원 조회
--#,^ 를 많이 씀.(ESCAPE 문자)
-- ESCAPE 문자 뒤에 작성된 _는 일반 문자로 탈출 한다는 뜻
SELECT EMP_NAME,EMAIL 
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--EMPLOYEE테이블에서 이메일 '_' 앞이 네글자 이면서 부서코드가 'D9' 또는 'D6' 이고 입사일이 1990-01-01 ~2000-12-31 사이이고 급여가 270이상인
--사원의 사번 이름 이메일 부서코드 입사일 급여 조회
SELECT EMP_ID, EMP_NAME, EMAIL,DEPT_CODE ,HIRE_DATE,SALARY
FROM EMPLOYEE
WHERE EMAIL LIKE '____#_%' ESCAPE '#' 
AND (DEPT_CODE ='D9'OR DEPT_CODE ='D6') 
AND HIRE_DATE BETWEEN '1990-01-01' AND '2000-12-31' 
AND SALARY > 2700000;

--연산자 우선순위

/*
 * 1. 산술 연산자 (+ - * /)
 * 2. 연결 연산자 ( || )
 * 3. 비교 연산자 ( > < >= <= = != <> )
 * 4. IS NULL / IS NOT NULL , LIKE, IN / LOT IN
 * 5. BETWEEN AND / NOT BETWEEN AND
 * 6.NOT(논리 연산자)
 * 7.AND(논리 연산자)
 * 8.OR(논리 연산자)
 *  
 */
 
--------------------------------------------------------------

/* IN 연산자
 * 
 * 비교하려는 값과 목록에 작성된 값 중
 * 일치하는 것이 있으면 조회하는 연산자
 * 
 * 작성법
 * WHERE 컬럼명 IN(값1,값2,값3....)
 * 
 */

--EMPLOYEE 테이블에서
--부서코드가 D1,D6,D9인 사언의 사번 이름 코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D1','D6','D9');

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN('D1','D6','D9')
OR DEPT_CODE IS NULL;
-- NULL가진 애들은 포함안되므로 OR로 NULL인애들 까지 포함시켜주기

--IS NULL , IS NOT NULL

---------------------------------------------------------------------

--NULL 처리 연산자

--JAVA에서 NULL : 참조하는 객체가 없음을 의미하는 값
--DB에서 NULL : 컬럼에 값이 없음을 의미하는 값

--1)IS NULL : NULL인 경우 조회
--2)IS NOT NULL : NULL이 아닌 경우 조회

--EMPOYEE 테이블에서 보너스가 있는 사원의 이름,보너스 조회

SELECT EMP_NAME,BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

---------------------------------------------------------------

--ORDER BY 절
--EMPLOYEE 테이브에서 급여 오름차순으로 

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
ORDER BY SALARY; -- ASC는 기본값이므로 굳이 안써줘도됨

--급여 200만 이상인 사원의 사번 이름 급여 조회
--단 급여 내림차순로 조회

SELECT EMP_NAME,EMP_ID,SALARY
FROM EMPLOYEE
WHERE SALARY >= 2000000
ORDER BY SALARY  DESC; -- SALARY 대신 3 가능 SELECT에서 SALARY가 3번째 있으므로 (컬럼순서로 쓴 것)

--입사일 순서대로 입사일 조회(별칭사용)

SELECT EMP_NAME 이름 ,HIRE_DATE 입사일 --별칭을 정해줘서
FROM EMPLOYEE
ORDER BY 입사일;                      -- 별칭을 이용한 것

--부서별 오름차순 , 급여별 내림차순

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
ORDER BY DEPT_CODE, SALARY DESC; -- 정렬 중첩 ',' 쓰기 , 대분류 정렬 후 소분류 정렬


-------------------------------------------------


