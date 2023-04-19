
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	add	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	add	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	286080e7          	jalr	646(ra) # 28e <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	280080e7          	jalr	640(ra) # 296 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	306080e7          	jalr	774(ra) # 326 <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <strcpy>:
  2a:	1141                	add	sp,sp,-16
  2c:	e422                	sd	s0,8(sp)
  2e:	0800                	add	s0,sp,16
  30:	87aa                	mv	a5,a0
  32:	0585                	add	a1,a1,1
  34:	0785                	add	a5,a5,1
  36:	fff5c703          	lbu	a4,-1(a1)
  3a:	fee78fa3          	sb	a4,-1(a5)
  3e:	fb75                	bnez	a4,32 <strcpy+0x8>
  40:	6422                	ld	s0,8(sp)
  42:	0141                	add	sp,sp,16
  44:	8082                	ret

0000000000000046 <strcmp>:
  46:	1141                	add	sp,sp,-16
  48:	e422                	sd	s0,8(sp)
  4a:	0800                	add	s0,sp,16
  4c:	00054783          	lbu	a5,0(a0)
  50:	cb91                	beqz	a5,64 <strcmp+0x1e>
  52:	0005c703          	lbu	a4,0(a1)
  56:	00f71763          	bne	a4,a5,64 <strcmp+0x1e>
  5a:	0505                	add	a0,a0,1
  5c:	0585                	add	a1,a1,1
  5e:	00054783          	lbu	a5,0(a0)
  62:	fbe5                	bnez	a5,52 <strcmp+0xc>
  64:	0005c503          	lbu	a0,0(a1)
  68:	40a7853b          	subw	a0,a5,a0
  6c:	6422                	ld	s0,8(sp)
  6e:	0141                	add	sp,sp,16
  70:	8082                	ret

0000000000000072 <strlen>:
  72:	1141                	add	sp,sp,-16
  74:	e422                	sd	s0,8(sp)
  76:	0800                	add	s0,sp,16
  78:	00054783          	lbu	a5,0(a0)
  7c:	cf91                	beqz	a5,98 <strlen+0x26>
  7e:	0505                	add	a0,a0,1
  80:	87aa                	mv	a5,a0
  82:	86be                	mv	a3,a5
  84:	0785                	add	a5,a5,1
  86:	fff7c703          	lbu	a4,-1(a5)
  8a:	ff65                	bnez	a4,82 <strlen+0x10>
  8c:	40a6853b          	subw	a0,a3,a0
  90:	2505                	addw	a0,a0,1
  92:	6422                	ld	s0,8(sp)
  94:	0141                	add	sp,sp,16
  96:	8082                	ret
  98:	4501                	li	a0,0
  9a:	bfe5                	j	92 <strlen+0x20>

000000000000009c <memset>:
  9c:	1141                	add	sp,sp,-16
  9e:	e422                	sd	s0,8(sp)
  a0:	0800                	add	s0,sp,16
  a2:	ca19                	beqz	a2,b8 <memset+0x1c>
  a4:	87aa                	mv	a5,a0
  a6:	1602                	sll	a2,a2,0x20
  a8:	9201                	srl	a2,a2,0x20
  aa:	00a60733          	add	a4,a2,a0
  ae:	00b78023          	sb	a1,0(a5)
  b2:	0785                	add	a5,a5,1
  b4:	fee79de3          	bne	a5,a4,ae <memset+0x12>
  b8:	6422                	ld	s0,8(sp)
  ba:	0141                	add	sp,sp,16
  bc:	8082                	ret

00000000000000be <strchr>:
  be:	1141                	add	sp,sp,-16
  c0:	e422                	sd	s0,8(sp)
  c2:	0800                	add	s0,sp,16
  c4:	00054783          	lbu	a5,0(a0)
  c8:	cb99                	beqz	a5,de <strchr+0x20>
  ca:	00f58763          	beq	a1,a5,d8 <strchr+0x1a>
  ce:	0505                	add	a0,a0,1
  d0:	00054783          	lbu	a5,0(a0)
  d4:	fbfd                	bnez	a5,ca <strchr+0xc>
  d6:	4501                	li	a0,0
  d8:	6422                	ld	s0,8(sp)
  da:	0141                	add	sp,sp,16
  dc:	8082                	ret
  de:	4501                	li	a0,0
  e0:	bfe5                	j	d8 <strchr+0x1a>

00000000000000e2 <gets>:
  e2:	711d                	add	sp,sp,-96
  e4:	ec86                	sd	ra,88(sp)
  e6:	e8a2                	sd	s0,80(sp)
  e8:	e4a6                	sd	s1,72(sp)
  ea:	e0ca                	sd	s2,64(sp)
  ec:	fc4e                	sd	s3,56(sp)
  ee:	f852                	sd	s4,48(sp)
  f0:	f456                	sd	s5,40(sp)
  f2:	f05a                	sd	s6,32(sp)
  f4:	ec5e                	sd	s7,24(sp)
  f6:	1080                	add	s0,sp,96
  f8:	8baa                	mv	s7,a0
  fa:	8a2e                	mv	s4,a1
  fc:	892a                	mv	s2,a0
  fe:	4481                	li	s1,0
 100:	4aa9                	li	s5,10
 102:	4b35                	li	s6,13
 104:	89a6                	mv	s3,s1
 106:	2485                	addw	s1,s1,1
 108:	0344d863          	bge	s1,s4,138 <gets+0x56>
 10c:	4605                	li	a2,1
 10e:	faf40593          	add	a1,s0,-81
 112:	4501                	li	a0,0
 114:	00000097          	auipc	ra,0x0
 118:	19a080e7          	jalr	410(ra) # 2ae <read>
 11c:	00a05e63          	blez	a0,138 <gets+0x56>
 120:	faf44783          	lbu	a5,-81(s0)
 124:	00f90023          	sb	a5,0(s2)
 128:	01578763          	beq	a5,s5,136 <gets+0x54>
 12c:	0905                	add	s2,s2,1
 12e:	fd679be3          	bne	a5,s6,104 <gets+0x22>
 132:	89a6                	mv	s3,s1
 134:	a011                	j	138 <gets+0x56>
 136:	89a6                	mv	s3,s1
 138:	99de                	add	s3,s3,s7
 13a:	00098023          	sb	zero,0(s3)
 13e:	855e                	mv	a0,s7
 140:	60e6                	ld	ra,88(sp)
 142:	6446                	ld	s0,80(sp)
 144:	64a6                	ld	s1,72(sp)
 146:	6906                	ld	s2,64(sp)
 148:	79e2                	ld	s3,56(sp)
 14a:	7a42                	ld	s4,48(sp)
 14c:	7aa2                	ld	s5,40(sp)
 14e:	7b02                	ld	s6,32(sp)
 150:	6be2                	ld	s7,24(sp)
 152:	6125                	add	sp,sp,96
 154:	8082                	ret

0000000000000156 <stat>:
 156:	1101                	add	sp,sp,-32
 158:	ec06                	sd	ra,24(sp)
 15a:	e822                	sd	s0,16(sp)
 15c:	e426                	sd	s1,8(sp)
 15e:	e04a                	sd	s2,0(sp)
 160:	1000                	add	s0,sp,32
 162:	892e                	mv	s2,a1
 164:	4581                	li	a1,0
 166:	00000097          	auipc	ra,0x0
 16a:	170080e7          	jalr	368(ra) # 2d6 <open>
 16e:	02054563          	bltz	a0,198 <stat+0x42>
 172:	84aa                	mv	s1,a0
 174:	85ca                	mv	a1,s2
 176:	00000097          	auipc	ra,0x0
 17a:	178080e7          	jalr	376(ra) # 2ee <fstat>
 17e:	892a                	mv	s2,a0
 180:	8526                	mv	a0,s1
 182:	00000097          	auipc	ra,0x0
 186:	13c080e7          	jalr	316(ra) # 2be <close>
 18a:	854a                	mv	a0,s2
 18c:	60e2                	ld	ra,24(sp)
 18e:	6442                	ld	s0,16(sp)
 190:	64a2                	ld	s1,8(sp)
 192:	6902                	ld	s2,0(sp)
 194:	6105                	add	sp,sp,32
 196:	8082                	ret
 198:	597d                	li	s2,-1
 19a:	bfc5                	j	18a <stat+0x34>

000000000000019c <atoi>:
 19c:	1141                	add	sp,sp,-16
 19e:	e422                	sd	s0,8(sp)
 1a0:	0800                	add	s0,sp,16
 1a2:	00054683          	lbu	a3,0(a0)
 1a6:	fd06879b          	addw	a5,a3,-48
 1aa:	0ff7f793          	zext.b	a5,a5
 1ae:	4625                	li	a2,9
 1b0:	02f66863          	bltu	a2,a5,1e0 <atoi+0x44>
 1b4:	872a                	mv	a4,a0
 1b6:	4501                	li	a0,0
 1b8:	0705                	add	a4,a4,1
 1ba:	0025179b          	sllw	a5,a0,0x2
 1be:	9fa9                	addw	a5,a5,a0
 1c0:	0017979b          	sllw	a5,a5,0x1
 1c4:	9fb5                	addw	a5,a5,a3
 1c6:	fd07851b          	addw	a0,a5,-48
 1ca:	00074683          	lbu	a3,0(a4)
 1ce:	fd06879b          	addw	a5,a3,-48
 1d2:	0ff7f793          	zext.b	a5,a5
 1d6:	fef671e3          	bgeu	a2,a5,1b8 <atoi+0x1c>
 1da:	6422                	ld	s0,8(sp)
 1dc:	0141                	add	sp,sp,16
 1de:	8082                	ret
 1e0:	4501                	li	a0,0
 1e2:	bfe5                	j	1da <atoi+0x3e>

00000000000001e4 <memmove>:
 1e4:	1141                	add	sp,sp,-16
 1e6:	e422                	sd	s0,8(sp)
 1e8:	0800                	add	s0,sp,16
 1ea:	02b57463          	bgeu	a0,a1,212 <memmove+0x2e>
 1ee:	00c05f63          	blez	a2,20c <memmove+0x28>
 1f2:	1602                	sll	a2,a2,0x20
 1f4:	9201                	srl	a2,a2,0x20
 1f6:	00c507b3          	add	a5,a0,a2
 1fa:	872a                	mv	a4,a0
 1fc:	0585                	add	a1,a1,1
 1fe:	0705                	add	a4,a4,1
 200:	fff5c683          	lbu	a3,-1(a1)
 204:	fed70fa3          	sb	a3,-1(a4)
 208:	fee79ae3          	bne	a5,a4,1fc <memmove+0x18>
 20c:	6422                	ld	s0,8(sp)
 20e:	0141                	add	sp,sp,16
 210:	8082                	ret
 212:	00c50733          	add	a4,a0,a2
 216:	95b2                	add	a1,a1,a2
 218:	fec05ae3          	blez	a2,20c <memmove+0x28>
 21c:	fff6079b          	addw	a5,a2,-1
 220:	1782                	sll	a5,a5,0x20
 222:	9381                	srl	a5,a5,0x20
 224:	fff7c793          	not	a5,a5
 228:	97ba                	add	a5,a5,a4
 22a:	15fd                	add	a1,a1,-1
 22c:	177d                	add	a4,a4,-1
 22e:	0005c683          	lbu	a3,0(a1)
 232:	00d70023          	sb	a3,0(a4)
 236:	fee79ae3          	bne	a5,a4,22a <memmove+0x46>
 23a:	bfc9                	j	20c <memmove+0x28>

000000000000023c <memcmp>:
 23c:	1141                	add	sp,sp,-16
 23e:	e422                	sd	s0,8(sp)
 240:	0800                	add	s0,sp,16
 242:	ca05                	beqz	a2,272 <memcmp+0x36>
 244:	fff6069b          	addw	a3,a2,-1
 248:	1682                	sll	a3,a3,0x20
 24a:	9281                	srl	a3,a3,0x20
 24c:	0685                	add	a3,a3,1
 24e:	96aa                	add	a3,a3,a0
 250:	00054783          	lbu	a5,0(a0)
 254:	0005c703          	lbu	a4,0(a1)
 258:	00e79863          	bne	a5,a4,268 <memcmp+0x2c>
 25c:	0505                	add	a0,a0,1
 25e:	0585                	add	a1,a1,1
 260:	fed518e3          	bne	a0,a3,250 <memcmp+0x14>
 264:	4501                	li	a0,0
 266:	a019                	j	26c <memcmp+0x30>
 268:	40e7853b          	subw	a0,a5,a4
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	add	sp,sp,16
 270:	8082                	ret
 272:	4501                	li	a0,0
 274:	bfe5                	j	26c <memcmp+0x30>

0000000000000276 <memcpy>:
 276:	1141                	add	sp,sp,-16
 278:	e406                	sd	ra,8(sp)
 27a:	e022                	sd	s0,0(sp)
 27c:	0800                	add	s0,sp,16
 27e:	00000097          	auipc	ra,0x0
 282:	f66080e7          	jalr	-154(ra) # 1e4 <memmove>
 286:	60a2                	ld	ra,8(sp)
 288:	6402                	ld	s0,0(sp)
 28a:	0141                	add	sp,sp,16
 28c:	8082                	ret

000000000000028e <fork>:
 28e:	4885                	li	a7,1
 290:	00000073          	ecall
 294:	8082                	ret

0000000000000296 <exit>:
 296:	4889                	li	a7,2
 298:	00000073          	ecall
 29c:	8082                	ret

000000000000029e <wait>:
 29e:	488d                	li	a7,3
 2a0:	00000073          	ecall
 2a4:	8082                	ret

00000000000002a6 <pipe>:
 2a6:	4891                	li	a7,4
 2a8:	00000073          	ecall
 2ac:	8082                	ret

00000000000002ae <read>:
 2ae:	4895                	li	a7,5
 2b0:	00000073          	ecall
 2b4:	8082                	ret

00000000000002b6 <write>:
 2b6:	48c1                	li	a7,16
 2b8:	00000073          	ecall
 2bc:	8082                	ret

00000000000002be <close>:
 2be:	48d5                	li	a7,21
 2c0:	00000073          	ecall
 2c4:	8082                	ret

00000000000002c6 <kill>:
 2c6:	4899                	li	a7,6
 2c8:	00000073          	ecall
 2cc:	8082                	ret

00000000000002ce <exec>:
 2ce:	489d                	li	a7,7
 2d0:	00000073          	ecall
 2d4:	8082                	ret

00000000000002d6 <open>:
 2d6:	48bd                	li	a7,15
 2d8:	00000073          	ecall
 2dc:	8082                	ret

00000000000002de <mknod>:
 2de:	48c5                	li	a7,17
 2e0:	00000073          	ecall
 2e4:	8082                	ret

00000000000002e6 <unlink>:
 2e6:	48c9                	li	a7,18
 2e8:	00000073          	ecall
 2ec:	8082                	ret

00000000000002ee <fstat>:
 2ee:	48a1                	li	a7,8
 2f0:	00000073          	ecall
 2f4:	8082                	ret

00000000000002f6 <link>:
 2f6:	48cd                	li	a7,19
 2f8:	00000073          	ecall
 2fc:	8082                	ret

00000000000002fe <mkdir>:
 2fe:	48d1                	li	a7,20
 300:	00000073          	ecall
 304:	8082                	ret

0000000000000306 <chdir>:
 306:	48a5                	li	a7,9
 308:	00000073          	ecall
 30c:	8082                	ret

000000000000030e <dup>:
 30e:	48a9                	li	a7,10
 310:	00000073          	ecall
 314:	8082                	ret

0000000000000316 <getpid>:
 316:	48ad                	li	a7,11
 318:	00000073          	ecall
 31c:	8082                	ret

000000000000031e <sbrk>:
 31e:	48b1                	li	a7,12
 320:	00000073          	ecall
 324:	8082                	ret

0000000000000326 <sleep>:
 326:	48b5                	li	a7,13
 328:	00000073          	ecall
 32c:	8082                	ret

000000000000032e <uptime>:
 32e:	48b9                	li	a7,14
 330:	00000073          	ecall
 334:	8082                	ret

0000000000000336 <putc>:
 336:	1101                	add	sp,sp,-32
 338:	ec06                	sd	ra,24(sp)
 33a:	e822                	sd	s0,16(sp)
 33c:	1000                	add	s0,sp,32
 33e:	feb407a3          	sb	a1,-17(s0)
 342:	4605                	li	a2,1
 344:	fef40593          	add	a1,s0,-17
 348:	00000097          	auipc	ra,0x0
 34c:	f6e080e7          	jalr	-146(ra) # 2b6 <write>
 350:	60e2                	ld	ra,24(sp)
 352:	6442                	ld	s0,16(sp)
 354:	6105                	add	sp,sp,32
 356:	8082                	ret

0000000000000358 <printint>:
 358:	7139                	add	sp,sp,-64
 35a:	fc06                	sd	ra,56(sp)
 35c:	f822                	sd	s0,48(sp)
 35e:	f426                	sd	s1,40(sp)
 360:	f04a                	sd	s2,32(sp)
 362:	ec4e                	sd	s3,24(sp)
 364:	0080                	add	s0,sp,64
 366:	84aa                	mv	s1,a0
 368:	c299                	beqz	a3,36e <printint+0x16>
 36a:	0805c963          	bltz	a1,3fc <printint+0xa4>
 36e:	2581                	sext.w	a1,a1
 370:	4881                	li	a7,0
 372:	fc040693          	add	a3,s0,-64
 376:	4701                	li	a4,0
 378:	2601                	sext.w	a2,a2
 37a:	00000517          	auipc	a0,0x0
 37e:	48650513          	add	a0,a0,1158 # 800 <digits>
 382:	883a                	mv	a6,a4
 384:	2705                	addw	a4,a4,1
 386:	02c5f7bb          	remuw	a5,a1,a2
 38a:	1782                	sll	a5,a5,0x20
 38c:	9381                	srl	a5,a5,0x20
 38e:	97aa                	add	a5,a5,a0
 390:	0007c783          	lbu	a5,0(a5)
 394:	00f68023          	sb	a5,0(a3)
 398:	0005879b          	sext.w	a5,a1
 39c:	02c5d5bb          	divuw	a1,a1,a2
 3a0:	0685                	add	a3,a3,1
 3a2:	fec7f0e3          	bgeu	a5,a2,382 <printint+0x2a>
 3a6:	00088c63          	beqz	a7,3be <printint+0x66>
 3aa:	fd070793          	add	a5,a4,-48
 3ae:	00878733          	add	a4,a5,s0
 3b2:	02d00793          	li	a5,45
 3b6:	fef70823          	sb	a5,-16(a4)
 3ba:	0028071b          	addw	a4,a6,2
 3be:	02e05863          	blez	a4,3ee <printint+0x96>
 3c2:	fc040793          	add	a5,s0,-64
 3c6:	00e78933          	add	s2,a5,a4
 3ca:	fff78993          	add	s3,a5,-1
 3ce:	99ba                	add	s3,s3,a4
 3d0:	377d                	addw	a4,a4,-1
 3d2:	1702                	sll	a4,a4,0x20
 3d4:	9301                	srl	a4,a4,0x20
 3d6:	40e989b3          	sub	s3,s3,a4
 3da:	fff94583          	lbu	a1,-1(s2)
 3de:	8526                	mv	a0,s1
 3e0:	00000097          	auipc	ra,0x0
 3e4:	f56080e7          	jalr	-170(ra) # 336 <putc>
 3e8:	197d                	add	s2,s2,-1
 3ea:	ff3918e3          	bne	s2,s3,3da <printint+0x82>
 3ee:	70e2                	ld	ra,56(sp)
 3f0:	7442                	ld	s0,48(sp)
 3f2:	74a2                	ld	s1,40(sp)
 3f4:	7902                	ld	s2,32(sp)
 3f6:	69e2                	ld	s3,24(sp)
 3f8:	6121                	add	sp,sp,64
 3fa:	8082                	ret
 3fc:	40b005bb          	negw	a1,a1
 400:	4885                	li	a7,1
 402:	bf85                	j	372 <printint+0x1a>

0000000000000404 <vprintf>:
 404:	715d                	add	sp,sp,-80
 406:	e486                	sd	ra,72(sp)
 408:	e0a2                	sd	s0,64(sp)
 40a:	fc26                	sd	s1,56(sp)
 40c:	f84a                	sd	s2,48(sp)
 40e:	f44e                	sd	s3,40(sp)
 410:	f052                	sd	s4,32(sp)
 412:	ec56                	sd	s5,24(sp)
 414:	e85a                	sd	s6,16(sp)
 416:	e45e                	sd	s7,8(sp)
 418:	e062                	sd	s8,0(sp)
 41a:	0880                	add	s0,sp,80
 41c:	0005c903          	lbu	s2,0(a1)
 420:	18090c63          	beqz	s2,5b8 <vprintf+0x1b4>
 424:	8aaa                	mv	s5,a0
 426:	8bb2                	mv	s7,a2
 428:	00158493          	add	s1,a1,1
 42c:	4981                	li	s3,0
 42e:	02500a13          	li	s4,37
 432:	4b55                	li	s6,21
 434:	a839                	j	452 <vprintf+0x4e>
 436:	85ca                	mv	a1,s2
 438:	8556                	mv	a0,s5
 43a:	00000097          	auipc	ra,0x0
 43e:	efc080e7          	jalr	-260(ra) # 336 <putc>
 442:	a019                	j	448 <vprintf+0x44>
 444:	01498d63          	beq	s3,s4,45e <vprintf+0x5a>
 448:	0485                	add	s1,s1,1
 44a:	fff4c903          	lbu	s2,-1(s1)
 44e:	16090563          	beqz	s2,5b8 <vprintf+0x1b4>
 452:	fe0999e3          	bnez	s3,444 <vprintf+0x40>
 456:	ff4910e3          	bne	s2,s4,436 <vprintf+0x32>
 45a:	89d2                	mv	s3,s4
 45c:	b7f5                	j	448 <vprintf+0x44>
 45e:	13490263          	beq	s2,s4,582 <vprintf+0x17e>
 462:	f9d9079b          	addw	a5,s2,-99
 466:	0ff7f793          	zext.b	a5,a5
 46a:	12fb6563          	bltu	s6,a5,594 <vprintf+0x190>
 46e:	f9d9079b          	addw	a5,s2,-99
 472:	0ff7f713          	zext.b	a4,a5
 476:	10eb6f63          	bltu	s6,a4,594 <vprintf+0x190>
 47a:	00271793          	sll	a5,a4,0x2
 47e:	00000717          	auipc	a4,0x0
 482:	32a70713          	add	a4,a4,810 # 7a8 <malloc+0xf2>
 486:	97ba                	add	a5,a5,a4
 488:	439c                	lw	a5,0(a5)
 48a:	97ba                	add	a5,a5,a4
 48c:	8782                	jr	a5
 48e:	008b8913          	add	s2,s7,8
 492:	4685                	li	a3,1
 494:	4629                	li	a2,10
 496:	000ba583          	lw	a1,0(s7)
 49a:	8556                	mv	a0,s5
 49c:	00000097          	auipc	ra,0x0
 4a0:	ebc080e7          	jalr	-324(ra) # 358 <printint>
 4a4:	8bca                	mv	s7,s2
 4a6:	4981                	li	s3,0
 4a8:	b745                	j	448 <vprintf+0x44>
 4aa:	008b8913          	add	s2,s7,8
 4ae:	4681                	li	a3,0
 4b0:	4629                	li	a2,10
 4b2:	000ba583          	lw	a1,0(s7)
 4b6:	8556                	mv	a0,s5
 4b8:	00000097          	auipc	ra,0x0
 4bc:	ea0080e7          	jalr	-352(ra) # 358 <printint>
 4c0:	8bca                	mv	s7,s2
 4c2:	4981                	li	s3,0
 4c4:	b751                	j	448 <vprintf+0x44>
 4c6:	008b8913          	add	s2,s7,8
 4ca:	4681                	li	a3,0
 4cc:	4641                	li	a2,16
 4ce:	000ba583          	lw	a1,0(s7)
 4d2:	8556                	mv	a0,s5
 4d4:	00000097          	auipc	ra,0x0
 4d8:	e84080e7          	jalr	-380(ra) # 358 <printint>
 4dc:	8bca                	mv	s7,s2
 4de:	4981                	li	s3,0
 4e0:	b7a5                	j	448 <vprintf+0x44>
 4e2:	008b8c13          	add	s8,s7,8
 4e6:	000bb983          	ld	s3,0(s7)
 4ea:	03000593          	li	a1,48
 4ee:	8556                	mv	a0,s5
 4f0:	00000097          	auipc	ra,0x0
 4f4:	e46080e7          	jalr	-442(ra) # 336 <putc>
 4f8:	07800593          	li	a1,120
 4fc:	8556                	mv	a0,s5
 4fe:	00000097          	auipc	ra,0x0
 502:	e38080e7          	jalr	-456(ra) # 336 <putc>
 506:	4941                	li	s2,16
 508:	00000b97          	auipc	s7,0x0
 50c:	2f8b8b93          	add	s7,s7,760 # 800 <digits>
 510:	03c9d793          	srl	a5,s3,0x3c
 514:	97de                	add	a5,a5,s7
 516:	0007c583          	lbu	a1,0(a5)
 51a:	8556                	mv	a0,s5
 51c:	00000097          	auipc	ra,0x0
 520:	e1a080e7          	jalr	-486(ra) # 336 <putc>
 524:	0992                	sll	s3,s3,0x4
 526:	397d                	addw	s2,s2,-1
 528:	fe0914e3          	bnez	s2,510 <vprintf+0x10c>
 52c:	8be2                	mv	s7,s8
 52e:	4981                	li	s3,0
 530:	bf21                	j	448 <vprintf+0x44>
 532:	008b8993          	add	s3,s7,8
 536:	000bb903          	ld	s2,0(s7)
 53a:	02090163          	beqz	s2,55c <vprintf+0x158>
 53e:	00094583          	lbu	a1,0(s2)
 542:	c9a5                	beqz	a1,5b2 <vprintf+0x1ae>
 544:	8556                	mv	a0,s5
 546:	00000097          	auipc	ra,0x0
 54a:	df0080e7          	jalr	-528(ra) # 336 <putc>
 54e:	0905                	add	s2,s2,1
 550:	00094583          	lbu	a1,0(s2)
 554:	f9e5                	bnez	a1,544 <vprintf+0x140>
 556:	8bce                	mv	s7,s3
 558:	4981                	li	s3,0
 55a:	b5fd                	j	448 <vprintf+0x44>
 55c:	00000917          	auipc	s2,0x0
 560:	24490913          	add	s2,s2,580 # 7a0 <malloc+0xea>
 564:	02800593          	li	a1,40
 568:	bff1                	j	544 <vprintf+0x140>
 56a:	008b8913          	add	s2,s7,8
 56e:	000bc583          	lbu	a1,0(s7)
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	dc2080e7          	jalr	-574(ra) # 336 <putc>
 57c:	8bca                	mv	s7,s2
 57e:	4981                	li	s3,0
 580:	b5e1                	j	448 <vprintf+0x44>
 582:	02500593          	li	a1,37
 586:	8556                	mv	a0,s5
 588:	00000097          	auipc	ra,0x0
 58c:	dae080e7          	jalr	-594(ra) # 336 <putc>
 590:	4981                	li	s3,0
 592:	bd5d                	j	448 <vprintf+0x44>
 594:	02500593          	li	a1,37
 598:	8556                	mv	a0,s5
 59a:	00000097          	auipc	ra,0x0
 59e:	d9c080e7          	jalr	-612(ra) # 336 <putc>
 5a2:	85ca                	mv	a1,s2
 5a4:	8556                	mv	a0,s5
 5a6:	00000097          	auipc	ra,0x0
 5aa:	d90080e7          	jalr	-624(ra) # 336 <putc>
 5ae:	4981                	li	s3,0
 5b0:	bd61                	j	448 <vprintf+0x44>
 5b2:	8bce                	mv	s7,s3
 5b4:	4981                	li	s3,0
 5b6:	bd49                	j	448 <vprintf+0x44>
 5b8:	60a6                	ld	ra,72(sp)
 5ba:	6406                	ld	s0,64(sp)
 5bc:	74e2                	ld	s1,56(sp)
 5be:	7942                	ld	s2,48(sp)
 5c0:	79a2                	ld	s3,40(sp)
 5c2:	7a02                	ld	s4,32(sp)
 5c4:	6ae2                	ld	s5,24(sp)
 5c6:	6b42                	ld	s6,16(sp)
 5c8:	6ba2                	ld	s7,8(sp)
 5ca:	6c02                	ld	s8,0(sp)
 5cc:	6161                	add	sp,sp,80
 5ce:	8082                	ret

00000000000005d0 <fprintf>:
 5d0:	715d                	add	sp,sp,-80
 5d2:	ec06                	sd	ra,24(sp)
 5d4:	e822                	sd	s0,16(sp)
 5d6:	1000                	add	s0,sp,32
 5d8:	e010                	sd	a2,0(s0)
 5da:	e414                	sd	a3,8(s0)
 5dc:	e818                	sd	a4,16(s0)
 5de:	ec1c                	sd	a5,24(s0)
 5e0:	03043023          	sd	a6,32(s0)
 5e4:	03143423          	sd	a7,40(s0)
 5e8:	fe843423          	sd	s0,-24(s0)
 5ec:	8622                	mv	a2,s0
 5ee:	00000097          	auipc	ra,0x0
 5f2:	e16080e7          	jalr	-490(ra) # 404 <vprintf>
 5f6:	60e2                	ld	ra,24(sp)
 5f8:	6442                	ld	s0,16(sp)
 5fa:	6161                	add	sp,sp,80
 5fc:	8082                	ret

00000000000005fe <printf>:
 5fe:	711d                	add	sp,sp,-96
 600:	ec06                	sd	ra,24(sp)
 602:	e822                	sd	s0,16(sp)
 604:	1000                	add	s0,sp,32
 606:	e40c                	sd	a1,8(s0)
 608:	e810                	sd	a2,16(s0)
 60a:	ec14                	sd	a3,24(s0)
 60c:	f018                	sd	a4,32(s0)
 60e:	f41c                	sd	a5,40(s0)
 610:	03043823          	sd	a6,48(s0)
 614:	03143c23          	sd	a7,56(s0)
 618:	00840613          	add	a2,s0,8
 61c:	fec43423          	sd	a2,-24(s0)
 620:	85aa                	mv	a1,a0
 622:	4505                	li	a0,1
 624:	00000097          	auipc	ra,0x0
 628:	de0080e7          	jalr	-544(ra) # 404 <vprintf>
 62c:	60e2                	ld	ra,24(sp)
 62e:	6442                	ld	s0,16(sp)
 630:	6125                	add	sp,sp,96
 632:	8082                	ret

0000000000000634 <free>:
 634:	1141                	add	sp,sp,-16
 636:	e422                	sd	s0,8(sp)
 638:	0800                	add	s0,sp,16
 63a:	ff050693          	add	a3,a0,-16
 63e:	00000797          	auipc	a5,0x0
 642:	1da7b783          	ld	a5,474(a5) # 818 <freep>
 646:	a02d                	j	670 <free+0x3c>
 648:	4618                	lw	a4,8(a2)
 64a:	9f2d                	addw	a4,a4,a1
 64c:	fee52c23          	sw	a4,-8(a0)
 650:	6398                	ld	a4,0(a5)
 652:	6310                	ld	a2,0(a4)
 654:	a83d                	j	692 <free+0x5e>
 656:	ff852703          	lw	a4,-8(a0)
 65a:	9f31                	addw	a4,a4,a2
 65c:	c798                	sw	a4,8(a5)
 65e:	ff053683          	ld	a3,-16(a0)
 662:	a091                	j	6a6 <free+0x72>
 664:	6398                	ld	a4,0(a5)
 666:	00e7e463          	bltu	a5,a4,66e <free+0x3a>
 66a:	00e6ea63          	bltu	a3,a4,67e <free+0x4a>
 66e:	87ba                	mv	a5,a4
 670:	fed7fae3          	bgeu	a5,a3,664 <free+0x30>
 674:	6398                	ld	a4,0(a5)
 676:	00e6e463          	bltu	a3,a4,67e <free+0x4a>
 67a:	fee7eae3          	bltu	a5,a4,66e <free+0x3a>
 67e:	ff852583          	lw	a1,-8(a0)
 682:	6390                	ld	a2,0(a5)
 684:	02059813          	sll	a6,a1,0x20
 688:	01c85713          	srl	a4,a6,0x1c
 68c:	9736                	add	a4,a4,a3
 68e:	fae60de3          	beq	a2,a4,648 <free+0x14>
 692:	fec53823          	sd	a2,-16(a0)
 696:	4790                	lw	a2,8(a5)
 698:	02061593          	sll	a1,a2,0x20
 69c:	01c5d713          	srl	a4,a1,0x1c
 6a0:	973e                	add	a4,a4,a5
 6a2:	fae68ae3          	beq	a3,a4,656 <free+0x22>
 6a6:	e394                	sd	a3,0(a5)
 6a8:	00000717          	auipc	a4,0x0
 6ac:	16f73823          	sd	a5,368(a4) # 818 <freep>
 6b0:	6422                	ld	s0,8(sp)
 6b2:	0141                	add	sp,sp,16
 6b4:	8082                	ret

00000000000006b6 <malloc>:
 6b6:	7139                	add	sp,sp,-64
 6b8:	fc06                	sd	ra,56(sp)
 6ba:	f822                	sd	s0,48(sp)
 6bc:	f426                	sd	s1,40(sp)
 6be:	f04a                	sd	s2,32(sp)
 6c0:	ec4e                	sd	s3,24(sp)
 6c2:	e852                	sd	s4,16(sp)
 6c4:	e456                	sd	s5,8(sp)
 6c6:	e05a                	sd	s6,0(sp)
 6c8:	0080                	add	s0,sp,64
 6ca:	02051493          	sll	s1,a0,0x20
 6ce:	9081                	srl	s1,s1,0x20
 6d0:	04bd                	add	s1,s1,15
 6d2:	8091                	srl	s1,s1,0x4
 6d4:	0014899b          	addw	s3,s1,1
 6d8:	0485                	add	s1,s1,1
 6da:	00000517          	auipc	a0,0x0
 6de:	13e53503          	ld	a0,318(a0) # 818 <freep>
 6e2:	c515                	beqz	a0,70e <malloc+0x58>
 6e4:	611c                	ld	a5,0(a0)
 6e6:	4798                	lw	a4,8(a5)
 6e8:	02977f63          	bgeu	a4,s1,726 <malloc+0x70>
 6ec:	8a4e                	mv	s4,s3
 6ee:	0009871b          	sext.w	a4,s3
 6f2:	6685                	lui	a3,0x1
 6f4:	00d77363          	bgeu	a4,a3,6fa <malloc+0x44>
 6f8:	6a05                	lui	s4,0x1
 6fa:	000a0b1b          	sext.w	s6,s4
 6fe:	004a1a1b          	sllw	s4,s4,0x4
 702:	00000917          	auipc	s2,0x0
 706:	11690913          	add	s2,s2,278 # 818 <freep>
 70a:	5afd                	li	s5,-1
 70c:	a895                	j	780 <malloc+0xca>
 70e:	00000797          	auipc	a5,0x0
 712:	11278793          	add	a5,a5,274 # 820 <base>
 716:	00000717          	auipc	a4,0x0
 71a:	10f73123          	sd	a5,258(a4) # 818 <freep>
 71e:	e39c                	sd	a5,0(a5)
 720:	0007a423          	sw	zero,8(a5)
 724:	b7e1                	j	6ec <malloc+0x36>
 726:	02e48c63          	beq	s1,a4,75e <malloc+0xa8>
 72a:	4137073b          	subw	a4,a4,s3
 72e:	c798                	sw	a4,8(a5)
 730:	02071693          	sll	a3,a4,0x20
 734:	01c6d713          	srl	a4,a3,0x1c
 738:	97ba                	add	a5,a5,a4
 73a:	0137a423          	sw	s3,8(a5)
 73e:	00000717          	auipc	a4,0x0
 742:	0ca73d23          	sd	a0,218(a4) # 818 <freep>
 746:	01078513          	add	a0,a5,16
 74a:	70e2                	ld	ra,56(sp)
 74c:	7442                	ld	s0,48(sp)
 74e:	74a2                	ld	s1,40(sp)
 750:	7902                	ld	s2,32(sp)
 752:	69e2                	ld	s3,24(sp)
 754:	6a42                	ld	s4,16(sp)
 756:	6aa2                	ld	s5,8(sp)
 758:	6b02                	ld	s6,0(sp)
 75a:	6121                	add	sp,sp,64
 75c:	8082                	ret
 75e:	6398                	ld	a4,0(a5)
 760:	e118                	sd	a4,0(a0)
 762:	bff1                	j	73e <malloc+0x88>
 764:	01652423          	sw	s6,8(a0)
 768:	0541                	add	a0,a0,16
 76a:	00000097          	auipc	ra,0x0
 76e:	eca080e7          	jalr	-310(ra) # 634 <free>
 772:	00093503          	ld	a0,0(s2)
 776:	d971                	beqz	a0,74a <malloc+0x94>
 778:	611c                	ld	a5,0(a0)
 77a:	4798                	lw	a4,8(a5)
 77c:	fa9775e3          	bgeu	a4,s1,726 <malloc+0x70>
 780:	00093703          	ld	a4,0(s2)
 784:	853e                	mv	a0,a5
 786:	fef719e3          	bne	a4,a5,778 <malloc+0xc2>
 78a:	8552                	mv	a0,s4
 78c:	00000097          	auipc	ra,0x0
 790:	b92080e7          	jalr	-1134(ra) # 31e <sbrk>
 794:	fd5518e3          	bne	a0,s5,764 <malloc+0xae>
 798:	4501                	li	a0,0
 79a:	bf45                	j	74a <malloc+0x94>