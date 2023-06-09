
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	add	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	add	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xor	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	add	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	add	a3,a3,797 # 1f31d <__global_pointer$+0x1d464>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	add	a2,a2,423 # 41a7 <__global_pointer$+0x22ee>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	add	a3,a3,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffd633>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	add	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	add	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	add	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	add	s0,sp,16
    return (do_rand(&rand_next));
      60:	00001517          	auipc	a0,0x1
      64:	66050513          	add	a0,a0,1632 # 16c0 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	add	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	add	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	add	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	df0080e7          	jalr	-528(ra) # e80 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	26650513          	add	a0,a0,614 # 1300 <malloc+0xe8>
      a2:	00001097          	auipc	ra,0x1
      a6:	dbe080e7          	jalr	-578(ra) # e60 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	25650513          	add	a0,a0,598 # 1300 <malloc+0xe8>
      b2:	00001097          	auipc	ra,0x1
      b6:	db6080e7          	jalr	-586(ra) # e68 <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	24c50513          	add	a0,a0,588 # 1308 <malloc+0xf0>
      c4:	00001097          	auipc	ra,0x1
      c8:	09c080e7          	jalr	156(ra) # 1160 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	d2a080e7          	jalr	-726(ra) # df8 <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	25250513          	add	a0,a0,594 # 1328 <malloc+0x110>
      de:	00001097          	auipc	ra,0x1
      e2:	d8a080e7          	jalr	-630(ra) # e68 <chdir>
      e6:	00001997          	auipc	s3,0x1
      ea:	25298993          	add	s3,s3,594 # 1338 <malloc+0x120>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	24098993          	add	s3,s3,576 # 1330 <malloc+0x118>
  uint64 iters = 0;
      f8:	4481                	li	s1,0
  int fd = -1;
      fa:	5a7d                	li	s4,-1
      fc:	00001917          	auipc	s2,0x1
     100:	4ec90913          	add	s2,s2,1260 # 15e8 <malloc+0x3d0>
     104:	a839                	j	122 <go+0xaa>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	23650513          	add	a0,a0,566 # 1340 <malloc+0x128>
     112:	00001097          	auipc	ra,0x1
     116:	d26080e7          	jalr	-730(ra) # e38 <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	d06080e7          	jalr	-762(ra) # e20 <close>
    iters++;
     122:	0485                	add	s1,s1,1
    if((iters % 500) == 0)
     124:	1f400793          	li	a5,500
     128:	02f4f7b3          	remu	a5,s1,a5
     12c:	eb81                	bnez	a5,13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
     12e:	4605                	li	a2,1
     130:	85ce                	mv	a1,s3
     132:	4505                	li	a0,1
     134:	00001097          	auipc	ra,0x1
     138:	ce4080e7          	jalr	-796(ra) # e18 <write>
    int what = rand() % 23;
     13c:	00000097          	auipc	ra,0x0
     140:	f1c080e7          	jalr	-228(ra) # 58 <rand>
     144:	47dd                	li	a5,23
     146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14a:	4785                	li	a5,1
     14c:	faf50de3          	beq	a0,a5,106 <go+0x8e>
    } else if(what == 2){
     150:	47d9                	li	a5,22
     152:	fca7e8e3          	bltu	a5,a0,122 <go+0xaa>
     156:	050a                	sll	a0,a0,0x2
     158:	954a                	add	a0,a0,s2
     15a:	411c                	lw	a5,0(a0)
     15c:	97ca                	add	a5,a5,s2
     15e:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     160:	20200593          	li	a1,514
     164:	00001517          	auipc	a0,0x1
     168:	1ec50513          	add	a0,a0,492 # 1350 <malloc+0x138>
     16c:	00001097          	auipc	ra,0x1
     170:	ccc080e7          	jalr	-820(ra) # e38 <open>
     174:	00001097          	auipc	ra,0x1
     178:	cac080e7          	jalr	-852(ra) # e20 <close>
     17c:	b75d                	j	122 <go+0xaa>
    } else if(what == 3){
      unlink("grindir/../a");
     17e:	00001517          	auipc	a0,0x1
     182:	1c250513          	add	a0,a0,450 # 1340 <malloc+0x128>
     186:	00001097          	auipc	ra,0x1
     18a:	cc2080e7          	jalr	-830(ra) # e48 <unlink>
     18e:	bf51                	j	122 <go+0xaa>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     190:	00001517          	auipc	a0,0x1
     194:	17050513          	add	a0,a0,368 # 1300 <malloc+0xe8>
     198:	00001097          	auipc	ra,0x1
     19c:	cd0080e7          	jalr	-816(ra) # e68 <chdir>
     1a0:	e115                	bnez	a0,1c4 <go+0x14c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     1a2:	00001517          	auipc	a0,0x1
     1a6:	1c650513          	add	a0,a0,454 # 1368 <malloc+0x150>
     1aa:	00001097          	auipc	ra,0x1
     1ae:	c9e080e7          	jalr	-866(ra) # e48 <unlink>
      chdir("/");
     1b2:	00001517          	auipc	a0,0x1
     1b6:	17650513          	add	a0,a0,374 # 1328 <malloc+0x110>
     1ba:	00001097          	auipc	ra,0x1
     1be:	cae080e7          	jalr	-850(ra) # e68 <chdir>
     1c2:	b785                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     1c4:	00001517          	auipc	a0,0x1
     1c8:	14450513          	add	a0,a0,324 # 1308 <malloc+0xf0>
     1cc:	00001097          	auipc	ra,0x1
     1d0:	f94080e7          	jalr	-108(ra) # 1160 <printf>
        exit(1);
     1d4:	4505                	li	a0,1
     1d6:	00001097          	auipc	ra,0x1
     1da:	c22080e7          	jalr	-990(ra) # df8 <exit>
    } else if(what == 5){
      close(fd);
     1de:	8552                	mv	a0,s4
     1e0:	00001097          	auipc	ra,0x1
     1e4:	c40080e7          	jalr	-960(ra) # e20 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1e8:	20200593          	li	a1,514
     1ec:	00001517          	auipc	a0,0x1
     1f0:	18450513          	add	a0,a0,388 # 1370 <malloc+0x158>
     1f4:	00001097          	auipc	ra,0x1
     1f8:	c44080e7          	jalr	-956(ra) # e38 <open>
     1fc:	8a2a                	mv	s4,a0
     1fe:	b715                	j	122 <go+0xaa>
    } else if(what == 6){
      close(fd);
     200:	8552                	mv	a0,s4
     202:	00001097          	auipc	ra,0x1
     206:	c1e080e7          	jalr	-994(ra) # e20 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	17250513          	add	a0,a0,370 # 1380 <malloc+0x168>
     216:	00001097          	auipc	ra,0x1
     21a:	c22080e7          	jalr	-990(ra) # e38 <open>
     21e:	8a2a                	mv	s4,a0
     220:	b709                	j	122 <go+0xaa>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     222:	3e700613          	li	a2,999
     226:	00001597          	auipc	a1,0x1
     22a:	4aa58593          	add	a1,a1,1194 # 16d0 <buf.0>
     22e:	8552                	mv	a0,s4
     230:	00001097          	auipc	ra,0x1
     234:	be8080e7          	jalr	-1048(ra) # e18 <write>
     238:	b5ed                	j	122 <go+0xaa>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     23a:	3e700613          	li	a2,999
     23e:	00001597          	auipc	a1,0x1
     242:	49258593          	add	a1,a1,1170 # 16d0 <buf.0>
     246:	8552                	mv	a0,s4
     248:	00001097          	auipc	ra,0x1
     24c:	bc8080e7          	jalr	-1080(ra) # e10 <read>
     250:	bdc9                	j	122 <go+0xaa>
    } else if(what == 9){
      mkdir("grindir/../a");
     252:	00001517          	auipc	a0,0x1
     256:	0ee50513          	add	a0,a0,238 # 1340 <malloc+0x128>
     25a:	00001097          	auipc	ra,0x1
     25e:	c06080e7          	jalr	-1018(ra) # e60 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     262:	20200593          	li	a1,514
     266:	00001517          	auipc	a0,0x1
     26a:	13250513          	add	a0,a0,306 # 1398 <malloc+0x180>
     26e:	00001097          	auipc	ra,0x1
     272:	bca080e7          	jalr	-1078(ra) # e38 <open>
     276:	00001097          	auipc	ra,0x1
     27a:	baa080e7          	jalr	-1110(ra) # e20 <close>
      unlink("a/a");
     27e:	00001517          	auipc	a0,0x1
     282:	12a50513          	add	a0,a0,298 # 13a8 <malloc+0x190>
     286:	00001097          	auipc	ra,0x1
     28a:	bc2080e7          	jalr	-1086(ra) # e48 <unlink>
     28e:	bd51                	j	122 <go+0xaa>
    } else if(what == 10){
      mkdir("/../b");
     290:	00001517          	auipc	a0,0x1
     294:	12050513          	add	a0,a0,288 # 13b0 <malloc+0x198>
     298:	00001097          	auipc	ra,0x1
     29c:	bc8080e7          	jalr	-1080(ra) # e60 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2a0:	20200593          	li	a1,514
     2a4:	00001517          	auipc	a0,0x1
     2a8:	11450513          	add	a0,a0,276 # 13b8 <malloc+0x1a0>
     2ac:	00001097          	auipc	ra,0x1
     2b0:	b8c080e7          	jalr	-1140(ra) # e38 <open>
     2b4:	00001097          	auipc	ra,0x1
     2b8:	b6c080e7          	jalr	-1172(ra) # e20 <close>
      unlink("b/b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	10c50513          	add	a0,a0,268 # 13c8 <malloc+0x1b0>
     2c4:	00001097          	auipc	ra,0x1
     2c8:	b84080e7          	jalr	-1148(ra) # e48 <unlink>
     2cc:	bd99                	j	122 <go+0xaa>
    } else if(what == 11){
      unlink("b");
     2ce:	00001517          	auipc	a0,0x1
     2d2:	0c250513          	add	a0,a0,194 # 1390 <malloc+0x178>
     2d6:	00001097          	auipc	ra,0x1
     2da:	b72080e7          	jalr	-1166(ra) # e48 <unlink>
      link("../grindir/./../a", "../b");
     2de:	00001597          	auipc	a1,0x1
     2e2:	08a58593          	add	a1,a1,138 # 1368 <malloc+0x150>
     2e6:	00001517          	auipc	a0,0x1
     2ea:	0ea50513          	add	a0,a0,234 # 13d0 <malloc+0x1b8>
     2ee:	00001097          	auipc	ra,0x1
     2f2:	b6a080e7          	jalr	-1174(ra) # e58 <link>
     2f6:	b535                	j	122 <go+0xaa>
    } else if(what == 12){
      unlink("../grindir/../a");
     2f8:	00001517          	auipc	a0,0x1
     2fc:	0f050513          	add	a0,a0,240 # 13e8 <malloc+0x1d0>
     300:	00001097          	auipc	ra,0x1
     304:	b48080e7          	jalr	-1208(ra) # e48 <unlink>
      link(".././b", "/grindir/../a");
     308:	00001597          	auipc	a1,0x1
     30c:	06858593          	add	a1,a1,104 # 1370 <malloc+0x158>
     310:	00001517          	auipc	a0,0x1
     314:	0e850513          	add	a0,a0,232 # 13f8 <malloc+0x1e0>
     318:	00001097          	auipc	ra,0x1
     31c:	b40080e7          	jalr	-1216(ra) # e58 <link>
     320:	b509                	j	122 <go+0xaa>
    } else if(what == 13){
      int pid = fork();
     322:	00001097          	auipc	ra,0x1
     326:	ace080e7          	jalr	-1330(ra) # df0 <fork>
      if(pid == 0){
     32a:	c909                	beqz	a0,33c <go+0x2c4>
        exit(0);
      } else if(pid < 0){
     32c:	00054c63          	bltz	a0,344 <go+0x2cc>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     330:	4501                	li	a0,0
     332:	00001097          	auipc	ra,0x1
     336:	ace080e7          	jalr	-1330(ra) # e00 <wait>
     33a:	b3e5                	j	122 <go+0xaa>
        exit(0);
     33c:	00001097          	auipc	ra,0x1
     340:	abc080e7          	jalr	-1348(ra) # df8 <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	0bc50513          	add	a0,a0,188 # 1400 <malloc+0x1e8>
     34c:	00001097          	auipc	ra,0x1
     350:	e14080e7          	jalr	-492(ra) # 1160 <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	00001097          	auipc	ra,0x1
     35a:	aa2080e7          	jalr	-1374(ra) # df8 <exit>
    } else if(what == 14){
      int pid = fork();
     35e:	00001097          	auipc	ra,0x1
     362:	a92080e7          	jalr	-1390(ra) # df0 <fork>
      if(pid == 0){
     366:	c909                	beqz	a0,378 <go+0x300>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     368:	02054563          	bltz	a0,392 <go+0x31a>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     36c:	4501                	li	a0,0
     36e:	00001097          	auipc	ra,0x1
     372:	a92080e7          	jalr	-1390(ra) # e00 <wait>
     376:	b375                	j	122 <go+0xaa>
        fork();
     378:	00001097          	auipc	ra,0x1
     37c:	a78080e7          	jalr	-1416(ra) # df0 <fork>
        fork();
     380:	00001097          	auipc	ra,0x1
     384:	a70080e7          	jalr	-1424(ra) # df0 <fork>
        exit(0);
     388:	4501                	li	a0,0
     38a:	00001097          	auipc	ra,0x1
     38e:	a6e080e7          	jalr	-1426(ra) # df8 <exit>
        printf("grind: fork failed\n");
     392:	00001517          	auipc	a0,0x1
     396:	06e50513          	add	a0,a0,110 # 1400 <malloc+0x1e8>
     39a:	00001097          	auipc	ra,0x1
     39e:	dc6080e7          	jalr	-570(ra) # 1160 <printf>
        exit(1);
     3a2:	4505                	li	a0,1
     3a4:	00001097          	auipc	ra,0x1
     3a8:	a54080e7          	jalr	-1452(ra) # df8 <exit>
    } else if(what == 15){
      sbrk(6011);
     3ac:	6505                	lui	a0,0x1
     3ae:	77b50513          	add	a0,a0,1915 # 177b <buf.0+0xab>
     3b2:	00001097          	auipc	ra,0x1
     3b6:	ace080e7          	jalr	-1330(ra) # e80 <sbrk>
     3ba:	b3a5                	j	122 <go+0xaa>
    } else if(what == 16){
      if(sbrk(0) > break0)
     3bc:	4501                	li	a0,0
     3be:	00001097          	auipc	ra,0x1
     3c2:	ac2080e7          	jalr	-1342(ra) # e80 <sbrk>
     3c6:	d4aafee3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     3ca:	4501                	li	a0,0
     3cc:	00001097          	auipc	ra,0x1
     3d0:	ab4080e7          	jalr	-1356(ra) # e80 <sbrk>
     3d4:	40aa853b          	subw	a0,s5,a0
     3d8:	00001097          	auipc	ra,0x1
     3dc:	aa8080e7          	jalr	-1368(ra) # e80 <sbrk>
     3e0:	b389                	j	122 <go+0xaa>
    } else if(what == 17){
      int pid = fork();
     3e2:	00001097          	auipc	ra,0x1
     3e6:	a0e080e7          	jalr	-1522(ra) # df0 <fork>
     3ea:	8b2a                	mv	s6,a0
      if(pid == 0){
     3ec:	c51d                	beqz	a0,41a <go+0x3a2>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     3ee:	04054963          	bltz	a0,440 <go+0x3c8>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     3f2:	00001517          	auipc	a0,0x1
     3f6:	02650513          	add	a0,a0,38 # 1418 <malloc+0x200>
     3fa:	00001097          	auipc	ra,0x1
     3fe:	a6e080e7          	jalr	-1426(ra) # e68 <chdir>
     402:	ed21                	bnez	a0,45a <go+0x3e2>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     404:	855a                	mv	a0,s6
     406:	00001097          	auipc	ra,0x1
     40a:	a22080e7          	jalr	-1502(ra) # e28 <kill>
      wait(0);
     40e:	4501                	li	a0,0
     410:	00001097          	auipc	ra,0x1
     414:	9f0080e7          	jalr	-1552(ra) # e00 <wait>
     418:	b329                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     41a:	20200593          	li	a1,514
     41e:	00001517          	auipc	a0,0x1
     422:	fc250513          	add	a0,a0,-62 # 13e0 <malloc+0x1c8>
     426:	00001097          	auipc	ra,0x1
     42a:	a12080e7          	jalr	-1518(ra) # e38 <open>
     42e:	00001097          	auipc	ra,0x1
     432:	9f2080e7          	jalr	-1550(ra) # e20 <close>
        exit(0);
     436:	4501                	li	a0,0
     438:	00001097          	auipc	ra,0x1
     43c:	9c0080e7          	jalr	-1600(ra) # df8 <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	fc050513          	add	a0,a0,-64 # 1400 <malloc+0x1e8>
     448:	00001097          	auipc	ra,0x1
     44c:	d18080e7          	jalr	-744(ra) # 1160 <printf>
        exit(1);
     450:	4505                	li	a0,1
     452:	00001097          	auipc	ra,0x1
     456:	9a6080e7          	jalr	-1626(ra) # df8 <exit>
        printf("grind: chdir failed\n");
     45a:	00001517          	auipc	a0,0x1
     45e:	fce50513          	add	a0,a0,-50 # 1428 <malloc+0x210>
     462:	00001097          	auipc	ra,0x1
     466:	cfe080e7          	jalr	-770(ra) # 1160 <printf>
        exit(1);
     46a:	4505                	li	a0,1
     46c:	00001097          	auipc	ra,0x1
     470:	98c080e7          	jalr	-1652(ra) # df8 <exit>
    } else if(what == 18){
      int pid = fork();
     474:	00001097          	auipc	ra,0x1
     478:	97c080e7          	jalr	-1668(ra) # df0 <fork>
      if(pid == 0){
     47c:	c909                	beqz	a0,48e <go+0x416>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     47e:	02054563          	bltz	a0,4a8 <go+0x430>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     482:	4501                	li	a0,0
     484:	00001097          	auipc	ra,0x1
     488:	97c080e7          	jalr	-1668(ra) # e00 <wait>
     48c:	b959                	j	122 <go+0xaa>
        kill(getpid());
     48e:	00001097          	auipc	ra,0x1
     492:	9ea080e7          	jalr	-1558(ra) # e78 <getpid>
     496:	00001097          	auipc	ra,0x1
     49a:	992080e7          	jalr	-1646(ra) # e28 <kill>
        exit(0);
     49e:	4501                	li	a0,0
     4a0:	00001097          	auipc	ra,0x1
     4a4:	958080e7          	jalr	-1704(ra) # df8 <exit>
        printf("grind: fork failed\n");
     4a8:	00001517          	auipc	a0,0x1
     4ac:	f5850513          	add	a0,a0,-168 # 1400 <malloc+0x1e8>
     4b0:	00001097          	auipc	ra,0x1
     4b4:	cb0080e7          	jalr	-848(ra) # 1160 <printf>
        exit(1);
     4b8:	4505                	li	a0,1
     4ba:	00001097          	auipc	ra,0x1
     4be:	93e080e7          	jalr	-1730(ra) # df8 <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     4c2:	fa840513          	add	a0,s0,-88
     4c6:	00001097          	auipc	ra,0x1
     4ca:	942080e7          	jalr	-1726(ra) # e08 <pipe>
     4ce:	02054b63          	bltz	a0,504 <go+0x48c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     4d2:	00001097          	auipc	ra,0x1
     4d6:	91e080e7          	jalr	-1762(ra) # df0 <fork>
      if(pid == 0){
     4da:	c131                	beqz	a0,51e <go+0x4a6>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     4dc:	0a054a63          	bltz	a0,590 <go+0x518>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     4e0:	fa842503          	lw	a0,-88(s0)
     4e4:	00001097          	auipc	ra,0x1
     4e8:	93c080e7          	jalr	-1732(ra) # e20 <close>
      close(fds[1]);
     4ec:	fac42503          	lw	a0,-84(s0)
     4f0:	00001097          	auipc	ra,0x1
     4f4:	930080e7          	jalr	-1744(ra) # e20 <close>
      wait(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	906080e7          	jalr	-1786(ra) # e00 <wait>
     502:	b105                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     504:	00001517          	auipc	a0,0x1
     508:	f3c50513          	add	a0,a0,-196 # 1440 <malloc+0x228>
     50c:	00001097          	auipc	ra,0x1
     510:	c54080e7          	jalr	-940(ra) # 1160 <printf>
        exit(1);
     514:	4505                	li	a0,1
     516:	00001097          	auipc	ra,0x1
     51a:	8e2080e7          	jalr	-1822(ra) # df8 <exit>
        fork();
     51e:	00001097          	auipc	ra,0x1
     522:	8d2080e7          	jalr	-1838(ra) # df0 <fork>
        fork();
     526:	00001097          	auipc	ra,0x1
     52a:	8ca080e7          	jalr	-1846(ra) # df0 <fork>
        if(write(fds[1], "x", 1) != 1)
     52e:	4605                	li	a2,1
     530:	00001597          	auipc	a1,0x1
     534:	f2858593          	add	a1,a1,-216 # 1458 <malloc+0x240>
     538:	fac42503          	lw	a0,-84(s0)
     53c:	00001097          	auipc	ra,0x1
     540:	8dc080e7          	jalr	-1828(ra) # e18 <write>
     544:	4785                	li	a5,1
     546:	02f51363          	bne	a0,a5,56c <go+0x4f4>
        if(read(fds[0], &c, 1) != 1)
     54a:	4605                	li	a2,1
     54c:	fa040593          	add	a1,s0,-96
     550:	fa842503          	lw	a0,-88(s0)
     554:	00001097          	auipc	ra,0x1
     558:	8bc080e7          	jalr	-1860(ra) # e10 <read>
     55c:	4785                	li	a5,1
     55e:	02f51063          	bne	a0,a5,57e <go+0x506>
        exit(0);
     562:	4501                	li	a0,0
     564:	00001097          	auipc	ra,0x1
     568:	894080e7          	jalr	-1900(ra) # df8 <exit>
          printf("grind: pipe write failed\n");
     56c:	00001517          	auipc	a0,0x1
     570:	ef450513          	add	a0,a0,-268 # 1460 <malloc+0x248>
     574:	00001097          	auipc	ra,0x1
     578:	bec080e7          	jalr	-1044(ra) # 1160 <printf>
     57c:	b7f9                	j	54a <go+0x4d2>
          printf("grind: pipe read failed\n");
     57e:	00001517          	auipc	a0,0x1
     582:	f0250513          	add	a0,a0,-254 # 1480 <malloc+0x268>
     586:	00001097          	auipc	ra,0x1
     58a:	bda080e7          	jalr	-1062(ra) # 1160 <printf>
     58e:	bfd1                	j	562 <go+0x4ea>
        printf("grind: fork failed\n");
     590:	00001517          	auipc	a0,0x1
     594:	e7050513          	add	a0,a0,-400 # 1400 <malloc+0x1e8>
     598:	00001097          	auipc	ra,0x1
     59c:	bc8080e7          	jalr	-1080(ra) # 1160 <printf>
        exit(1);
     5a0:	4505                	li	a0,1
     5a2:	00001097          	auipc	ra,0x1
     5a6:	856080e7          	jalr	-1962(ra) # df8 <exit>
    } else if(what == 20){
      int pid = fork();
     5aa:	00001097          	auipc	ra,0x1
     5ae:	846080e7          	jalr	-1978(ra) # df0 <fork>
      if(pid == 0){
     5b2:	c909                	beqz	a0,5c4 <go+0x54c>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     5b4:	06054f63          	bltz	a0,632 <go+0x5ba>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     5b8:	4501                	li	a0,0
     5ba:	00001097          	auipc	ra,0x1
     5be:	846080e7          	jalr	-1978(ra) # e00 <wait>
     5c2:	b685                	j	122 <go+0xaa>
        unlink("a");
     5c4:	00001517          	auipc	a0,0x1
     5c8:	e1c50513          	add	a0,a0,-484 # 13e0 <malloc+0x1c8>
     5cc:	00001097          	auipc	ra,0x1
     5d0:	87c080e7          	jalr	-1924(ra) # e48 <unlink>
        mkdir("a");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	e0c50513          	add	a0,a0,-500 # 13e0 <malloc+0x1c8>
     5dc:	00001097          	auipc	ra,0x1
     5e0:	884080e7          	jalr	-1916(ra) # e60 <mkdir>
        chdir("a");
     5e4:	00001517          	auipc	a0,0x1
     5e8:	dfc50513          	add	a0,a0,-516 # 13e0 <malloc+0x1c8>
     5ec:	00001097          	auipc	ra,0x1
     5f0:	87c080e7          	jalr	-1924(ra) # e68 <chdir>
        unlink("../a");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	d5450513          	add	a0,a0,-684 # 1348 <malloc+0x130>
     5fc:	00001097          	auipc	ra,0x1
     600:	84c080e7          	jalr	-1972(ra) # e48 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     604:	20200593          	li	a1,514
     608:	00001517          	auipc	a0,0x1
     60c:	e5050513          	add	a0,a0,-432 # 1458 <malloc+0x240>
     610:	00001097          	auipc	ra,0x1
     614:	828080e7          	jalr	-2008(ra) # e38 <open>
        unlink("x");
     618:	00001517          	auipc	a0,0x1
     61c:	e4050513          	add	a0,a0,-448 # 1458 <malloc+0x240>
     620:	00001097          	auipc	ra,0x1
     624:	828080e7          	jalr	-2008(ra) # e48 <unlink>
        exit(0);
     628:	4501                	li	a0,0
     62a:	00000097          	auipc	ra,0x0
     62e:	7ce080e7          	jalr	1998(ra) # df8 <exit>
        printf("grind: fork failed\n");
     632:	00001517          	auipc	a0,0x1
     636:	dce50513          	add	a0,a0,-562 # 1400 <malloc+0x1e8>
     63a:	00001097          	auipc	ra,0x1
     63e:	b26080e7          	jalr	-1242(ra) # 1160 <printf>
        exit(1);
     642:	4505                	li	a0,1
     644:	00000097          	auipc	ra,0x0
     648:	7b4080e7          	jalr	1972(ra) # df8 <exit>
    } else if(what == 21){
      unlink("c");
     64c:	00001517          	auipc	a0,0x1
     650:	e5450513          	add	a0,a0,-428 # 14a0 <malloc+0x288>
     654:	00000097          	auipc	ra,0x0
     658:	7f4080e7          	jalr	2036(ra) # e48 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     65c:	20200593          	li	a1,514
     660:	00001517          	auipc	a0,0x1
     664:	e4050513          	add	a0,a0,-448 # 14a0 <malloc+0x288>
     668:	00000097          	auipc	ra,0x0
     66c:	7d0080e7          	jalr	2000(ra) # e38 <open>
     670:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     672:	04054f63          	bltz	a0,6d0 <go+0x658>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     676:	4605                	li	a2,1
     678:	00001597          	auipc	a1,0x1
     67c:	de058593          	add	a1,a1,-544 # 1458 <malloc+0x240>
     680:	00000097          	auipc	ra,0x0
     684:	798080e7          	jalr	1944(ra) # e18 <write>
     688:	4785                	li	a5,1
     68a:	06f51063          	bne	a0,a5,6ea <go+0x672>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     68e:	fa840593          	add	a1,s0,-88
     692:	855a                	mv	a0,s6
     694:	00000097          	auipc	ra,0x0
     698:	7bc080e7          	jalr	1980(ra) # e50 <fstat>
     69c:	e525                	bnez	a0,704 <go+0x68c>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     69e:	fb843583          	ld	a1,-72(s0)
     6a2:	4785                	li	a5,1
     6a4:	06f59d63          	bne	a1,a5,71e <go+0x6a6>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     6a8:	fac42583          	lw	a1,-84(s0)
     6ac:	0c800793          	li	a5,200
     6b0:	08b7e563          	bltu	a5,a1,73a <go+0x6c2>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     6b4:	855a                	mv	a0,s6
     6b6:	00000097          	auipc	ra,0x0
     6ba:	76a080e7          	jalr	1898(ra) # e20 <close>
      unlink("c");
     6be:	00001517          	auipc	a0,0x1
     6c2:	de250513          	add	a0,a0,-542 # 14a0 <malloc+0x288>
     6c6:	00000097          	auipc	ra,0x0
     6ca:	782080e7          	jalr	1922(ra) # e48 <unlink>
     6ce:	bc91                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     6d0:	00001517          	auipc	a0,0x1
     6d4:	dd850513          	add	a0,a0,-552 # 14a8 <malloc+0x290>
     6d8:	00001097          	auipc	ra,0x1
     6dc:	a88080e7          	jalr	-1400(ra) # 1160 <printf>
        exit(1);
     6e0:	4505                	li	a0,1
     6e2:	00000097          	auipc	ra,0x0
     6e6:	716080e7          	jalr	1814(ra) # df8 <exit>
        printf("grind: write c failed\n");
     6ea:	00001517          	auipc	a0,0x1
     6ee:	dd650513          	add	a0,a0,-554 # 14c0 <malloc+0x2a8>
     6f2:	00001097          	auipc	ra,0x1
     6f6:	a6e080e7          	jalr	-1426(ra) # 1160 <printf>
        exit(1);
     6fa:	4505                	li	a0,1
     6fc:	00000097          	auipc	ra,0x0
     700:	6fc080e7          	jalr	1788(ra) # df8 <exit>
        printf("grind: fstat failed\n");
     704:	00001517          	auipc	a0,0x1
     708:	dd450513          	add	a0,a0,-556 # 14d8 <malloc+0x2c0>
     70c:	00001097          	auipc	ra,0x1
     710:	a54080e7          	jalr	-1452(ra) # 1160 <printf>
        exit(1);
     714:	4505                	li	a0,1
     716:	00000097          	auipc	ra,0x0
     71a:	6e2080e7          	jalr	1762(ra) # df8 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     71e:	2581                	sext.w	a1,a1
     720:	00001517          	auipc	a0,0x1
     724:	dd050513          	add	a0,a0,-560 # 14f0 <malloc+0x2d8>
     728:	00001097          	auipc	ra,0x1
     72c:	a38080e7          	jalr	-1480(ra) # 1160 <printf>
        exit(1);
     730:	4505                	li	a0,1
     732:	00000097          	auipc	ra,0x0
     736:	6c6080e7          	jalr	1734(ra) # df8 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     73a:	00001517          	auipc	a0,0x1
     73e:	dde50513          	add	a0,a0,-546 # 1518 <malloc+0x300>
     742:	00001097          	auipc	ra,0x1
     746:	a1e080e7          	jalr	-1506(ra) # 1160 <printf>
        exit(1);
     74a:	4505                	li	a0,1
     74c:	00000097          	auipc	ra,0x0
     750:	6ac080e7          	jalr	1708(ra) # df8 <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     754:	f9840513          	add	a0,s0,-104
     758:	00000097          	auipc	ra,0x0
     75c:	6b0080e7          	jalr	1712(ra) # e08 <pipe>
     760:	10054063          	bltz	a0,860 <go+0x7e8>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     764:	fa040513          	add	a0,s0,-96
     768:	00000097          	auipc	ra,0x0
     76c:	6a0080e7          	jalr	1696(ra) # e08 <pipe>
     770:	10054663          	bltz	a0,87c <go+0x804>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     774:	00000097          	auipc	ra,0x0
     778:	67c080e7          	jalr	1660(ra) # df0 <fork>
      if(pid1 == 0){
     77c:	10050e63          	beqz	a0,898 <go+0x820>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     780:	1c054663          	bltz	a0,94c <go+0x8d4>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     784:	00000097          	auipc	ra,0x0
     788:	66c080e7          	jalr	1644(ra) # df0 <fork>
      if(pid2 == 0){
     78c:	1c050e63          	beqz	a0,968 <go+0x8f0>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     790:	2a054a63          	bltz	a0,a44 <go+0x9cc>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     794:	f9842503          	lw	a0,-104(s0)
     798:	00000097          	auipc	ra,0x0
     79c:	688080e7          	jalr	1672(ra) # e20 <close>
      close(aa[1]);
     7a0:	f9c42503          	lw	a0,-100(s0)
     7a4:	00000097          	auipc	ra,0x0
     7a8:	67c080e7          	jalr	1660(ra) # e20 <close>
      close(bb[1]);
     7ac:	fa442503          	lw	a0,-92(s0)
     7b0:	00000097          	auipc	ra,0x0
     7b4:	670080e7          	jalr	1648(ra) # e20 <close>
      char buf[4] = { 0, 0, 0, 0 };
     7b8:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     7bc:	4605                	li	a2,1
     7be:	f9040593          	add	a1,s0,-112
     7c2:	fa042503          	lw	a0,-96(s0)
     7c6:	00000097          	auipc	ra,0x0
     7ca:	64a080e7          	jalr	1610(ra) # e10 <read>
      read(bb[0], buf+1, 1);
     7ce:	4605                	li	a2,1
     7d0:	f9140593          	add	a1,s0,-111
     7d4:	fa042503          	lw	a0,-96(s0)
     7d8:	00000097          	auipc	ra,0x0
     7dc:	638080e7          	jalr	1592(ra) # e10 <read>
      read(bb[0], buf+2, 1);
     7e0:	4605                	li	a2,1
     7e2:	f9240593          	add	a1,s0,-110
     7e6:	fa042503          	lw	a0,-96(s0)
     7ea:	00000097          	auipc	ra,0x0
     7ee:	626080e7          	jalr	1574(ra) # e10 <read>
      close(bb[0]);
     7f2:	fa042503          	lw	a0,-96(s0)
     7f6:	00000097          	auipc	ra,0x0
     7fa:	62a080e7          	jalr	1578(ra) # e20 <close>
      int st1, st2;
      wait(&st1);
     7fe:	f9440513          	add	a0,s0,-108
     802:	00000097          	auipc	ra,0x0
     806:	5fe080e7          	jalr	1534(ra) # e00 <wait>
      wait(&st2);
     80a:	fa840513          	add	a0,s0,-88
     80e:	00000097          	auipc	ra,0x0
     812:	5f2080e7          	jalr	1522(ra) # e00 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     816:	f9442783          	lw	a5,-108(s0)
     81a:	fa842703          	lw	a4,-88(s0)
     81e:	8fd9                	or	a5,a5,a4
     820:	ef89                	bnez	a5,83a <go+0x7c2>
     822:	00001597          	auipc	a1,0x1
     826:	d9658593          	add	a1,a1,-618 # 15b8 <malloc+0x3a0>
     82a:	f9040513          	add	a0,s0,-112
     82e:	00000097          	auipc	ra,0x0
     832:	37a080e7          	jalr	890(ra) # ba8 <strcmp>
     836:	8e0506e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     83a:	f9040693          	add	a3,s0,-112
     83e:	fa842603          	lw	a2,-88(s0)
     842:	f9442583          	lw	a1,-108(s0)
     846:	00001517          	auipc	a0,0x1
     84a:	d7a50513          	add	a0,a0,-646 # 15c0 <malloc+0x3a8>
     84e:	00001097          	auipc	ra,0x1
     852:	912080e7          	jalr	-1774(ra) # 1160 <printf>
        exit(1);
     856:	4505                	li	a0,1
     858:	00000097          	auipc	ra,0x0
     85c:	5a0080e7          	jalr	1440(ra) # df8 <exit>
        fprintf(2, "grind: pipe failed\n");
     860:	00001597          	auipc	a1,0x1
     864:	be058593          	add	a1,a1,-1056 # 1440 <malloc+0x228>
     868:	4509                	li	a0,2
     86a:	00001097          	auipc	ra,0x1
     86e:	8c8080e7          	jalr	-1848(ra) # 1132 <fprintf>
        exit(1);
     872:	4505                	li	a0,1
     874:	00000097          	auipc	ra,0x0
     878:	584080e7          	jalr	1412(ra) # df8 <exit>
        fprintf(2, "grind: pipe failed\n");
     87c:	00001597          	auipc	a1,0x1
     880:	bc458593          	add	a1,a1,-1084 # 1440 <malloc+0x228>
     884:	4509                	li	a0,2
     886:	00001097          	auipc	ra,0x1
     88a:	8ac080e7          	jalr	-1876(ra) # 1132 <fprintf>
        exit(1);
     88e:	4505                	li	a0,1
     890:	00000097          	auipc	ra,0x0
     894:	568080e7          	jalr	1384(ra) # df8 <exit>
        close(bb[0]);
     898:	fa042503          	lw	a0,-96(s0)
     89c:	00000097          	auipc	ra,0x0
     8a0:	584080e7          	jalr	1412(ra) # e20 <close>
        close(bb[1]);
     8a4:	fa442503          	lw	a0,-92(s0)
     8a8:	00000097          	auipc	ra,0x0
     8ac:	578080e7          	jalr	1400(ra) # e20 <close>
        close(aa[0]);
     8b0:	f9842503          	lw	a0,-104(s0)
     8b4:	00000097          	auipc	ra,0x0
     8b8:	56c080e7          	jalr	1388(ra) # e20 <close>
        close(1);
     8bc:	4505                	li	a0,1
     8be:	00000097          	auipc	ra,0x0
     8c2:	562080e7          	jalr	1378(ra) # e20 <close>
        if(dup(aa[1]) != 1){
     8c6:	f9c42503          	lw	a0,-100(s0)
     8ca:	00000097          	auipc	ra,0x0
     8ce:	5a6080e7          	jalr	1446(ra) # e70 <dup>
     8d2:	4785                	li	a5,1
     8d4:	02f50063          	beq	a0,a5,8f4 <go+0x87c>
          fprintf(2, "grind: dup failed\n");
     8d8:	00001597          	auipc	a1,0x1
     8dc:	c6858593          	add	a1,a1,-920 # 1540 <malloc+0x328>
     8e0:	4509                	li	a0,2
     8e2:	00001097          	auipc	ra,0x1
     8e6:	850080e7          	jalr	-1968(ra) # 1132 <fprintf>
          exit(1);
     8ea:	4505                	li	a0,1
     8ec:	00000097          	auipc	ra,0x0
     8f0:	50c080e7          	jalr	1292(ra) # df8 <exit>
        close(aa[1]);
     8f4:	f9c42503          	lw	a0,-100(s0)
     8f8:	00000097          	auipc	ra,0x0
     8fc:	528080e7          	jalr	1320(ra) # e20 <close>
        char *args[3] = { "echo", "hi", 0 };
     900:	00001797          	auipc	a5,0x1
     904:	c5878793          	add	a5,a5,-936 # 1558 <malloc+0x340>
     908:	faf43423          	sd	a5,-88(s0)
     90c:	00001797          	auipc	a5,0x1
     910:	c5478793          	add	a5,a5,-940 # 1560 <malloc+0x348>
     914:	faf43823          	sd	a5,-80(s0)
     918:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     91c:	fa840593          	add	a1,s0,-88
     920:	00001517          	auipc	a0,0x1
     924:	c4850513          	add	a0,a0,-952 # 1568 <malloc+0x350>
     928:	00000097          	auipc	ra,0x0
     92c:	508080e7          	jalr	1288(ra) # e30 <exec>
        fprintf(2, "grind: echo: not found\n");
     930:	00001597          	auipc	a1,0x1
     934:	c4858593          	add	a1,a1,-952 # 1578 <malloc+0x360>
     938:	4509                	li	a0,2
     93a:	00000097          	auipc	ra,0x0
     93e:	7f8080e7          	jalr	2040(ra) # 1132 <fprintf>
        exit(2);
     942:	4509                	li	a0,2
     944:	00000097          	auipc	ra,0x0
     948:	4b4080e7          	jalr	1204(ra) # df8 <exit>
        fprintf(2, "grind: fork failed\n");
     94c:	00001597          	auipc	a1,0x1
     950:	ab458593          	add	a1,a1,-1356 # 1400 <malloc+0x1e8>
     954:	4509                	li	a0,2
     956:	00000097          	auipc	ra,0x0
     95a:	7dc080e7          	jalr	2012(ra) # 1132 <fprintf>
        exit(3);
     95e:	450d                	li	a0,3
     960:	00000097          	auipc	ra,0x0
     964:	498080e7          	jalr	1176(ra) # df8 <exit>
        close(aa[1]);
     968:	f9c42503          	lw	a0,-100(s0)
     96c:	00000097          	auipc	ra,0x0
     970:	4b4080e7          	jalr	1204(ra) # e20 <close>
        close(bb[0]);
     974:	fa042503          	lw	a0,-96(s0)
     978:	00000097          	auipc	ra,0x0
     97c:	4a8080e7          	jalr	1192(ra) # e20 <close>
        close(0);
     980:	4501                	li	a0,0
     982:	00000097          	auipc	ra,0x0
     986:	49e080e7          	jalr	1182(ra) # e20 <close>
        if(dup(aa[0]) != 0){
     98a:	f9842503          	lw	a0,-104(s0)
     98e:	00000097          	auipc	ra,0x0
     992:	4e2080e7          	jalr	1250(ra) # e70 <dup>
     996:	cd19                	beqz	a0,9b4 <go+0x93c>
          fprintf(2, "grind: dup failed\n");
     998:	00001597          	auipc	a1,0x1
     99c:	ba858593          	add	a1,a1,-1112 # 1540 <malloc+0x328>
     9a0:	4509                	li	a0,2
     9a2:	00000097          	auipc	ra,0x0
     9a6:	790080e7          	jalr	1936(ra) # 1132 <fprintf>
          exit(4);
     9aa:	4511                	li	a0,4
     9ac:	00000097          	auipc	ra,0x0
     9b0:	44c080e7          	jalr	1100(ra) # df8 <exit>
        close(aa[0]);
     9b4:	f9842503          	lw	a0,-104(s0)
     9b8:	00000097          	auipc	ra,0x0
     9bc:	468080e7          	jalr	1128(ra) # e20 <close>
        close(1);
     9c0:	4505                	li	a0,1
     9c2:	00000097          	auipc	ra,0x0
     9c6:	45e080e7          	jalr	1118(ra) # e20 <close>
        if(dup(bb[1]) != 1){
     9ca:	fa442503          	lw	a0,-92(s0)
     9ce:	00000097          	auipc	ra,0x0
     9d2:	4a2080e7          	jalr	1186(ra) # e70 <dup>
     9d6:	4785                	li	a5,1
     9d8:	02f50063          	beq	a0,a5,9f8 <go+0x980>
          fprintf(2, "grind: dup failed\n");
     9dc:	00001597          	auipc	a1,0x1
     9e0:	b6458593          	add	a1,a1,-1180 # 1540 <malloc+0x328>
     9e4:	4509                	li	a0,2
     9e6:	00000097          	auipc	ra,0x0
     9ea:	74c080e7          	jalr	1868(ra) # 1132 <fprintf>
          exit(5);
     9ee:	4515                	li	a0,5
     9f0:	00000097          	auipc	ra,0x0
     9f4:	408080e7          	jalr	1032(ra) # df8 <exit>
        close(bb[1]);
     9f8:	fa442503          	lw	a0,-92(s0)
     9fc:	00000097          	auipc	ra,0x0
     a00:	424080e7          	jalr	1060(ra) # e20 <close>
        char *args[2] = { "cat", 0 };
     a04:	00001797          	auipc	a5,0x1
     a08:	b8c78793          	add	a5,a5,-1140 # 1590 <malloc+0x378>
     a0c:	faf43423          	sd	a5,-88(s0)
     a10:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a14:	fa840593          	add	a1,s0,-88
     a18:	00001517          	auipc	a0,0x1
     a1c:	b8050513          	add	a0,a0,-1152 # 1598 <malloc+0x380>
     a20:	00000097          	auipc	ra,0x0
     a24:	410080e7          	jalr	1040(ra) # e30 <exec>
        fprintf(2, "grind: cat: not found\n");
     a28:	00001597          	auipc	a1,0x1
     a2c:	b7858593          	add	a1,a1,-1160 # 15a0 <malloc+0x388>
     a30:	4509                	li	a0,2
     a32:	00000097          	auipc	ra,0x0
     a36:	700080e7          	jalr	1792(ra) # 1132 <fprintf>
        exit(6);
     a3a:	4519                	li	a0,6
     a3c:	00000097          	auipc	ra,0x0
     a40:	3bc080e7          	jalr	956(ra) # df8 <exit>
        fprintf(2, "grind: fork failed\n");
     a44:	00001597          	auipc	a1,0x1
     a48:	9bc58593          	add	a1,a1,-1604 # 1400 <malloc+0x1e8>
     a4c:	4509                	li	a0,2
     a4e:	00000097          	auipc	ra,0x0
     a52:	6e4080e7          	jalr	1764(ra) # 1132 <fprintf>
        exit(7);
     a56:	451d                	li	a0,7
     a58:	00000097          	auipc	ra,0x0
     a5c:	3a0080e7          	jalr	928(ra) # df8 <exit>

0000000000000a60 <iter>:
  }
}

void
iter()
{
     a60:	7179                	add	sp,sp,-48
     a62:	f406                	sd	ra,40(sp)
     a64:	f022                	sd	s0,32(sp)
     a66:	ec26                	sd	s1,24(sp)
     a68:	e84a                	sd	s2,16(sp)
     a6a:	1800                	add	s0,sp,48
  unlink("a");
     a6c:	00001517          	auipc	a0,0x1
     a70:	97450513          	add	a0,a0,-1676 # 13e0 <malloc+0x1c8>
     a74:	00000097          	auipc	ra,0x0
     a78:	3d4080e7          	jalr	980(ra) # e48 <unlink>
  unlink("b");
     a7c:	00001517          	auipc	a0,0x1
     a80:	91450513          	add	a0,a0,-1772 # 1390 <malloc+0x178>
     a84:	00000097          	auipc	ra,0x0
     a88:	3c4080e7          	jalr	964(ra) # e48 <unlink>
  
  int pid1 = fork();
     a8c:	00000097          	auipc	ra,0x0
     a90:	364080e7          	jalr	868(ra) # df0 <fork>
  if(pid1 < 0){
     a94:	00054e63          	bltz	a0,ab0 <iter+0x50>
     a98:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     a9a:	e905                	bnez	a0,aca <iter+0x6a>
    rand_next = 31;
     a9c:	47fd                	li	a5,31
     a9e:	00001717          	auipc	a4,0x1
     aa2:	c2f73123          	sd	a5,-990(a4) # 16c0 <rand_next>
    go(0);
     aa6:	4501                	li	a0,0
     aa8:	fffff097          	auipc	ra,0xfffff
     aac:	5d0080e7          	jalr	1488(ra) # 78 <go>
    printf("grind: fork failed\n");
     ab0:	00001517          	auipc	a0,0x1
     ab4:	95050513          	add	a0,a0,-1712 # 1400 <malloc+0x1e8>
     ab8:	00000097          	auipc	ra,0x0
     abc:	6a8080e7          	jalr	1704(ra) # 1160 <printf>
    exit(1);
     ac0:	4505                	li	a0,1
     ac2:	00000097          	auipc	ra,0x0
     ac6:	336080e7          	jalr	822(ra) # df8 <exit>
    exit(0);
  }

  int pid2 = fork();
     aca:	00000097          	auipc	ra,0x0
     ace:	326080e7          	jalr	806(ra) # df0 <fork>
     ad2:	892a                	mv	s2,a0
  if(pid2 < 0){
     ad4:	00054f63          	bltz	a0,af2 <iter+0x92>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     ad8:	e915                	bnez	a0,b0c <iter+0xac>
    rand_next = 7177;
     ada:	6789                	lui	a5,0x2
     adc:	c0978793          	add	a5,a5,-1015 # 1c09 <__BSS_END__+0x141>
     ae0:	00001717          	auipc	a4,0x1
     ae4:	bef73023          	sd	a5,-1056(a4) # 16c0 <rand_next>
    go(1);
     ae8:	4505                	li	a0,1
     aea:	fffff097          	auipc	ra,0xfffff
     aee:	58e080e7          	jalr	1422(ra) # 78 <go>
    printf("grind: fork failed\n");
     af2:	00001517          	auipc	a0,0x1
     af6:	90e50513          	add	a0,a0,-1778 # 1400 <malloc+0x1e8>
     afa:	00000097          	auipc	ra,0x0
     afe:	666080e7          	jalr	1638(ra) # 1160 <printf>
    exit(1);
     b02:	4505                	li	a0,1
     b04:	00000097          	auipc	ra,0x0
     b08:	2f4080e7          	jalr	756(ra) # df8 <exit>
    exit(0);
  }

  int st1 = -1;
     b0c:	57fd                	li	a5,-1
     b0e:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b12:	fdc40513          	add	a0,s0,-36
     b16:	00000097          	auipc	ra,0x0
     b1a:	2ea080e7          	jalr	746(ra) # e00 <wait>
  if(st1 != 0){
     b1e:	fdc42783          	lw	a5,-36(s0)
     b22:	ef99                	bnez	a5,b40 <iter+0xe0>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     b24:	57fd                	li	a5,-1
     b26:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     b2a:	fd840513          	add	a0,s0,-40
     b2e:	00000097          	auipc	ra,0x0
     b32:	2d2080e7          	jalr	722(ra) # e00 <wait>

  exit(0);
     b36:	4501                	li	a0,0
     b38:	00000097          	auipc	ra,0x0
     b3c:	2c0080e7          	jalr	704(ra) # df8 <exit>
    kill(pid1);
     b40:	8526                	mv	a0,s1
     b42:	00000097          	auipc	ra,0x0
     b46:	2e6080e7          	jalr	742(ra) # e28 <kill>
    kill(pid2);
     b4a:	854a                	mv	a0,s2
     b4c:	00000097          	auipc	ra,0x0
     b50:	2dc080e7          	jalr	732(ra) # e28 <kill>
     b54:	bfc1                	j	b24 <iter+0xc4>

0000000000000b56 <main>:
}

int
main()
{
     b56:	1141                	add	sp,sp,-16
     b58:	e406                	sd	ra,8(sp)
     b5a:	e022                	sd	s0,0(sp)
     b5c:	0800                	add	s0,sp,16
     b5e:	a811                	j	b72 <main+0x1c>
  while(1){
    int pid = fork();
    if(pid == 0){
      iter();
     b60:	00000097          	auipc	ra,0x0
     b64:	f00080e7          	jalr	-256(ra) # a60 <iter>
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
     b68:	4551                	li	a0,20
     b6a:	00000097          	auipc	ra,0x0
     b6e:	31e080e7          	jalr	798(ra) # e88 <sleep>
    int pid = fork();
     b72:	00000097          	auipc	ra,0x0
     b76:	27e080e7          	jalr	638(ra) # df0 <fork>
    if(pid == 0){
     b7a:	d17d                	beqz	a0,b60 <main+0xa>
    if(pid > 0){
     b7c:	fea056e3          	blez	a0,b68 <main+0x12>
      wait(0);
     b80:	4501                	li	a0,0
     b82:	00000097          	auipc	ra,0x0
     b86:	27e080e7          	jalr	638(ra) # e00 <wait>
     b8a:	bff9                	j	b68 <main+0x12>

0000000000000b8c <strcpy>:
     b8c:	1141                	add	sp,sp,-16
     b8e:	e422                	sd	s0,8(sp)
     b90:	0800                	add	s0,sp,16
     b92:	87aa                	mv	a5,a0
     b94:	0585                	add	a1,a1,1
     b96:	0785                	add	a5,a5,1
     b98:	fff5c703          	lbu	a4,-1(a1)
     b9c:	fee78fa3          	sb	a4,-1(a5)
     ba0:	fb75                	bnez	a4,b94 <strcpy+0x8>
     ba2:	6422                	ld	s0,8(sp)
     ba4:	0141                	add	sp,sp,16
     ba6:	8082                	ret

0000000000000ba8 <strcmp>:
     ba8:	1141                	add	sp,sp,-16
     baa:	e422                	sd	s0,8(sp)
     bac:	0800                	add	s0,sp,16
     bae:	00054783          	lbu	a5,0(a0)
     bb2:	cb91                	beqz	a5,bc6 <strcmp+0x1e>
     bb4:	0005c703          	lbu	a4,0(a1)
     bb8:	00f71763          	bne	a4,a5,bc6 <strcmp+0x1e>
     bbc:	0505                	add	a0,a0,1
     bbe:	0585                	add	a1,a1,1
     bc0:	00054783          	lbu	a5,0(a0)
     bc4:	fbe5                	bnez	a5,bb4 <strcmp+0xc>
     bc6:	0005c503          	lbu	a0,0(a1)
     bca:	40a7853b          	subw	a0,a5,a0
     bce:	6422                	ld	s0,8(sp)
     bd0:	0141                	add	sp,sp,16
     bd2:	8082                	ret

0000000000000bd4 <strlen>:
     bd4:	1141                	add	sp,sp,-16
     bd6:	e422                	sd	s0,8(sp)
     bd8:	0800                	add	s0,sp,16
     bda:	00054783          	lbu	a5,0(a0)
     bde:	cf91                	beqz	a5,bfa <strlen+0x26>
     be0:	0505                	add	a0,a0,1
     be2:	87aa                	mv	a5,a0
     be4:	86be                	mv	a3,a5
     be6:	0785                	add	a5,a5,1
     be8:	fff7c703          	lbu	a4,-1(a5)
     bec:	ff65                	bnez	a4,be4 <strlen+0x10>
     bee:	40a6853b          	subw	a0,a3,a0
     bf2:	2505                	addw	a0,a0,1
     bf4:	6422                	ld	s0,8(sp)
     bf6:	0141                	add	sp,sp,16
     bf8:	8082                	ret
     bfa:	4501                	li	a0,0
     bfc:	bfe5                	j	bf4 <strlen+0x20>

0000000000000bfe <memset>:
     bfe:	1141                	add	sp,sp,-16
     c00:	e422                	sd	s0,8(sp)
     c02:	0800                	add	s0,sp,16
     c04:	ca19                	beqz	a2,c1a <memset+0x1c>
     c06:	87aa                	mv	a5,a0
     c08:	1602                	sll	a2,a2,0x20
     c0a:	9201                	srl	a2,a2,0x20
     c0c:	00a60733          	add	a4,a2,a0
     c10:	00b78023          	sb	a1,0(a5)
     c14:	0785                	add	a5,a5,1
     c16:	fee79de3          	bne	a5,a4,c10 <memset+0x12>
     c1a:	6422                	ld	s0,8(sp)
     c1c:	0141                	add	sp,sp,16
     c1e:	8082                	ret

0000000000000c20 <strchr>:
     c20:	1141                	add	sp,sp,-16
     c22:	e422                	sd	s0,8(sp)
     c24:	0800                	add	s0,sp,16
     c26:	00054783          	lbu	a5,0(a0)
     c2a:	cb99                	beqz	a5,c40 <strchr+0x20>
     c2c:	00f58763          	beq	a1,a5,c3a <strchr+0x1a>
     c30:	0505                	add	a0,a0,1
     c32:	00054783          	lbu	a5,0(a0)
     c36:	fbfd                	bnez	a5,c2c <strchr+0xc>
     c38:	4501                	li	a0,0
     c3a:	6422                	ld	s0,8(sp)
     c3c:	0141                	add	sp,sp,16
     c3e:	8082                	ret
     c40:	4501                	li	a0,0
     c42:	bfe5                	j	c3a <strchr+0x1a>

0000000000000c44 <gets>:
     c44:	711d                	add	sp,sp,-96
     c46:	ec86                	sd	ra,88(sp)
     c48:	e8a2                	sd	s0,80(sp)
     c4a:	e4a6                	sd	s1,72(sp)
     c4c:	e0ca                	sd	s2,64(sp)
     c4e:	fc4e                	sd	s3,56(sp)
     c50:	f852                	sd	s4,48(sp)
     c52:	f456                	sd	s5,40(sp)
     c54:	f05a                	sd	s6,32(sp)
     c56:	ec5e                	sd	s7,24(sp)
     c58:	1080                	add	s0,sp,96
     c5a:	8baa                	mv	s7,a0
     c5c:	8a2e                	mv	s4,a1
     c5e:	892a                	mv	s2,a0
     c60:	4481                	li	s1,0
     c62:	4aa9                	li	s5,10
     c64:	4b35                	li	s6,13
     c66:	89a6                	mv	s3,s1
     c68:	2485                	addw	s1,s1,1
     c6a:	0344d863          	bge	s1,s4,c9a <gets+0x56>
     c6e:	4605                	li	a2,1
     c70:	faf40593          	add	a1,s0,-81
     c74:	4501                	li	a0,0
     c76:	00000097          	auipc	ra,0x0
     c7a:	19a080e7          	jalr	410(ra) # e10 <read>
     c7e:	00a05e63          	blez	a0,c9a <gets+0x56>
     c82:	faf44783          	lbu	a5,-81(s0)
     c86:	00f90023          	sb	a5,0(s2)
     c8a:	01578763          	beq	a5,s5,c98 <gets+0x54>
     c8e:	0905                	add	s2,s2,1
     c90:	fd679be3          	bne	a5,s6,c66 <gets+0x22>
     c94:	89a6                	mv	s3,s1
     c96:	a011                	j	c9a <gets+0x56>
     c98:	89a6                	mv	s3,s1
     c9a:	99de                	add	s3,s3,s7
     c9c:	00098023          	sb	zero,0(s3)
     ca0:	855e                	mv	a0,s7
     ca2:	60e6                	ld	ra,88(sp)
     ca4:	6446                	ld	s0,80(sp)
     ca6:	64a6                	ld	s1,72(sp)
     ca8:	6906                	ld	s2,64(sp)
     caa:	79e2                	ld	s3,56(sp)
     cac:	7a42                	ld	s4,48(sp)
     cae:	7aa2                	ld	s5,40(sp)
     cb0:	7b02                	ld	s6,32(sp)
     cb2:	6be2                	ld	s7,24(sp)
     cb4:	6125                	add	sp,sp,96
     cb6:	8082                	ret

0000000000000cb8 <stat>:
     cb8:	1101                	add	sp,sp,-32
     cba:	ec06                	sd	ra,24(sp)
     cbc:	e822                	sd	s0,16(sp)
     cbe:	e426                	sd	s1,8(sp)
     cc0:	e04a                	sd	s2,0(sp)
     cc2:	1000                	add	s0,sp,32
     cc4:	892e                	mv	s2,a1
     cc6:	4581                	li	a1,0
     cc8:	00000097          	auipc	ra,0x0
     ccc:	170080e7          	jalr	368(ra) # e38 <open>
     cd0:	02054563          	bltz	a0,cfa <stat+0x42>
     cd4:	84aa                	mv	s1,a0
     cd6:	85ca                	mv	a1,s2
     cd8:	00000097          	auipc	ra,0x0
     cdc:	178080e7          	jalr	376(ra) # e50 <fstat>
     ce0:	892a                	mv	s2,a0
     ce2:	8526                	mv	a0,s1
     ce4:	00000097          	auipc	ra,0x0
     ce8:	13c080e7          	jalr	316(ra) # e20 <close>
     cec:	854a                	mv	a0,s2
     cee:	60e2                	ld	ra,24(sp)
     cf0:	6442                	ld	s0,16(sp)
     cf2:	64a2                	ld	s1,8(sp)
     cf4:	6902                	ld	s2,0(sp)
     cf6:	6105                	add	sp,sp,32
     cf8:	8082                	ret
     cfa:	597d                	li	s2,-1
     cfc:	bfc5                	j	cec <stat+0x34>

0000000000000cfe <atoi>:
     cfe:	1141                	add	sp,sp,-16
     d00:	e422                	sd	s0,8(sp)
     d02:	0800                	add	s0,sp,16
     d04:	00054683          	lbu	a3,0(a0)
     d08:	fd06879b          	addw	a5,a3,-48
     d0c:	0ff7f793          	zext.b	a5,a5
     d10:	4625                	li	a2,9
     d12:	02f66863          	bltu	a2,a5,d42 <atoi+0x44>
     d16:	872a                	mv	a4,a0
     d18:	4501                	li	a0,0
     d1a:	0705                	add	a4,a4,1
     d1c:	0025179b          	sllw	a5,a0,0x2
     d20:	9fa9                	addw	a5,a5,a0
     d22:	0017979b          	sllw	a5,a5,0x1
     d26:	9fb5                	addw	a5,a5,a3
     d28:	fd07851b          	addw	a0,a5,-48
     d2c:	00074683          	lbu	a3,0(a4)
     d30:	fd06879b          	addw	a5,a3,-48
     d34:	0ff7f793          	zext.b	a5,a5
     d38:	fef671e3          	bgeu	a2,a5,d1a <atoi+0x1c>
     d3c:	6422                	ld	s0,8(sp)
     d3e:	0141                	add	sp,sp,16
     d40:	8082                	ret
     d42:	4501                	li	a0,0
     d44:	bfe5                	j	d3c <atoi+0x3e>

0000000000000d46 <memmove>:
     d46:	1141                	add	sp,sp,-16
     d48:	e422                	sd	s0,8(sp)
     d4a:	0800                	add	s0,sp,16
     d4c:	02b57463          	bgeu	a0,a1,d74 <memmove+0x2e>
     d50:	00c05f63          	blez	a2,d6e <memmove+0x28>
     d54:	1602                	sll	a2,a2,0x20
     d56:	9201                	srl	a2,a2,0x20
     d58:	00c507b3          	add	a5,a0,a2
     d5c:	872a                	mv	a4,a0
     d5e:	0585                	add	a1,a1,1
     d60:	0705                	add	a4,a4,1
     d62:	fff5c683          	lbu	a3,-1(a1)
     d66:	fed70fa3          	sb	a3,-1(a4)
     d6a:	fee79ae3          	bne	a5,a4,d5e <memmove+0x18>
     d6e:	6422                	ld	s0,8(sp)
     d70:	0141                	add	sp,sp,16
     d72:	8082                	ret
     d74:	00c50733          	add	a4,a0,a2
     d78:	95b2                	add	a1,a1,a2
     d7a:	fec05ae3          	blez	a2,d6e <memmove+0x28>
     d7e:	fff6079b          	addw	a5,a2,-1
     d82:	1782                	sll	a5,a5,0x20
     d84:	9381                	srl	a5,a5,0x20
     d86:	fff7c793          	not	a5,a5
     d8a:	97ba                	add	a5,a5,a4
     d8c:	15fd                	add	a1,a1,-1
     d8e:	177d                	add	a4,a4,-1
     d90:	0005c683          	lbu	a3,0(a1)
     d94:	00d70023          	sb	a3,0(a4)
     d98:	fee79ae3          	bne	a5,a4,d8c <memmove+0x46>
     d9c:	bfc9                	j	d6e <memmove+0x28>

0000000000000d9e <memcmp>:
     d9e:	1141                	add	sp,sp,-16
     da0:	e422                	sd	s0,8(sp)
     da2:	0800                	add	s0,sp,16
     da4:	ca05                	beqz	a2,dd4 <memcmp+0x36>
     da6:	fff6069b          	addw	a3,a2,-1
     daa:	1682                	sll	a3,a3,0x20
     dac:	9281                	srl	a3,a3,0x20
     dae:	0685                	add	a3,a3,1
     db0:	96aa                	add	a3,a3,a0
     db2:	00054783          	lbu	a5,0(a0)
     db6:	0005c703          	lbu	a4,0(a1)
     dba:	00e79863          	bne	a5,a4,dca <memcmp+0x2c>
     dbe:	0505                	add	a0,a0,1
     dc0:	0585                	add	a1,a1,1
     dc2:	fed518e3          	bne	a0,a3,db2 <memcmp+0x14>
     dc6:	4501                	li	a0,0
     dc8:	a019                	j	dce <memcmp+0x30>
     dca:	40e7853b          	subw	a0,a5,a4
     dce:	6422                	ld	s0,8(sp)
     dd0:	0141                	add	sp,sp,16
     dd2:	8082                	ret
     dd4:	4501                	li	a0,0
     dd6:	bfe5                	j	dce <memcmp+0x30>

0000000000000dd8 <memcpy>:
     dd8:	1141                	add	sp,sp,-16
     dda:	e406                	sd	ra,8(sp)
     ddc:	e022                	sd	s0,0(sp)
     dde:	0800                	add	s0,sp,16
     de0:	00000097          	auipc	ra,0x0
     de4:	f66080e7          	jalr	-154(ra) # d46 <memmove>
     de8:	60a2                	ld	ra,8(sp)
     dea:	6402                	ld	s0,0(sp)
     dec:	0141                	add	sp,sp,16
     dee:	8082                	ret

0000000000000df0 <fork>:
     df0:	4885                	li	a7,1
     df2:	00000073          	ecall
     df6:	8082                	ret

0000000000000df8 <exit>:
     df8:	4889                	li	a7,2
     dfa:	00000073          	ecall
     dfe:	8082                	ret

0000000000000e00 <wait>:
     e00:	488d                	li	a7,3
     e02:	00000073          	ecall
     e06:	8082                	ret

0000000000000e08 <pipe>:
     e08:	4891                	li	a7,4
     e0a:	00000073          	ecall
     e0e:	8082                	ret

0000000000000e10 <read>:
     e10:	4895                	li	a7,5
     e12:	00000073          	ecall
     e16:	8082                	ret

0000000000000e18 <write>:
     e18:	48c1                	li	a7,16
     e1a:	00000073          	ecall
     e1e:	8082                	ret

0000000000000e20 <close>:
     e20:	48d5                	li	a7,21
     e22:	00000073          	ecall
     e26:	8082                	ret

0000000000000e28 <kill>:
     e28:	4899                	li	a7,6
     e2a:	00000073          	ecall
     e2e:	8082                	ret

0000000000000e30 <exec>:
     e30:	489d                	li	a7,7
     e32:	00000073          	ecall
     e36:	8082                	ret

0000000000000e38 <open>:
     e38:	48bd                	li	a7,15
     e3a:	00000073          	ecall
     e3e:	8082                	ret

0000000000000e40 <mknod>:
     e40:	48c5                	li	a7,17
     e42:	00000073          	ecall
     e46:	8082                	ret

0000000000000e48 <unlink>:
     e48:	48c9                	li	a7,18
     e4a:	00000073          	ecall
     e4e:	8082                	ret

0000000000000e50 <fstat>:
     e50:	48a1                	li	a7,8
     e52:	00000073          	ecall
     e56:	8082                	ret

0000000000000e58 <link>:
     e58:	48cd                	li	a7,19
     e5a:	00000073          	ecall
     e5e:	8082                	ret

0000000000000e60 <mkdir>:
     e60:	48d1                	li	a7,20
     e62:	00000073          	ecall
     e66:	8082                	ret

0000000000000e68 <chdir>:
     e68:	48a5                	li	a7,9
     e6a:	00000073          	ecall
     e6e:	8082                	ret

0000000000000e70 <dup>:
     e70:	48a9                	li	a7,10
     e72:	00000073          	ecall
     e76:	8082                	ret

0000000000000e78 <getpid>:
     e78:	48ad                	li	a7,11
     e7a:	00000073          	ecall
     e7e:	8082                	ret

0000000000000e80 <sbrk>:
     e80:	48b1                	li	a7,12
     e82:	00000073          	ecall
     e86:	8082                	ret

0000000000000e88 <sleep>:
     e88:	48b5                	li	a7,13
     e8a:	00000073          	ecall
     e8e:	8082                	ret

0000000000000e90 <uptime>:
     e90:	48b9                	li	a7,14
     e92:	00000073          	ecall
     e96:	8082                	ret

0000000000000e98 <putc>:
     e98:	1101                	add	sp,sp,-32
     e9a:	ec06                	sd	ra,24(sp)
     e9c:	e822                	sd	s0,16(sp)
     e9e:	1000                	add	s0,sp,32
     ea0:	feb407a3          	sb	a1,-17(s0)
     ea4:	4605                	li	a2,1
     ea6:	fef40593          	add	a1,s0,-17
     eaa:	00000097          	auipc	ra,0x0
     eae:	f6e080e7          	jalr	-146(ra) # e18 <write>
     eb2:	60e2                	ld	ra,24(sp)
     eb4:	6442                	ld	s0,16(sp)
     eb6:	6105                	add	sp,sp,32
     eb8:	8082                	ret

0000000000000eba <printint>:
     eba:	7139                	add	sp,sp,-64
     ebc:	fc06                	sd	ra,56(sp)
     ebe:	f822                	sd	s0,48(sp)
     ec0:	f426                	sd	s1,40(sp)
     ec2:	f04a                	sd	s2,32(sp)
     ec4:	ec4e                	sd	s3,24(sp)
     ec6:	0080                	add	s0,sp,64
     ec8:	84aa                	mv	s1,a0
     eca:	c299                	beqz	a3,ed0 <printint+0x16>
     ecc:	0805c963          	bltz	a1,f5e <printint+0xa4>
     ed0:	2581                	sext.w	a1,a1
     ed2:	4881                	li	a7,0
     ed4:	fc040693          	add	a3,s0,-64
     ed8:	4701                	li	a4,0
     eda:	2601                	sext.w	a2,a2
     edc:	00000517          	auipc	a0,0x0
     ee0:	7cc50513          	add	a0,a0,1996 # 16a8 <digits>
     ee4:	883a                	mv	a6,a4
     ee6:	2705                	addw	a4,a4,1
     ee8:	02c5f7bb          	remuw	a5,a1,a2
     eec:	1782                	sll	a5,a5,0x20
     eee:	9381                	srl	a5,a5,0x20
     ef0:	97aa                	add	a5,a5,a0
     ef2:	0007c783          	lbu	a5,0(a5)
     ef6:	00f68023          	sb	a5,0(a3)
     efa:	0005879b          	sext.w	a5,a1
     efe:	02c5d5bb          	divuw	a1,a1,a2
     f02:	0685                	add	a3,a3,1
     f04:	fec7f0e3          	bgeu	a5,a2,ee4 <printint+0x2a>
     f08:	00088c63          	beqz	a7,f20 <printint+0x66>
     f0c:	fd070793          	add	a5,a4,-48
     f10:	00878733          	add	a4,a5,s0
     f14:	02d00793          	li	a5,45
     f18:	fef70823          	sb	a5,-16(a4)
     f1c:	0028071b          	addw	a4,a6,2
     f20:	02e05863          	blez	a4,f50 <printint+0x96>
     f24:	fc040793          	add	a5,s0,-64
     f28:	00e78933          	add	s2,a5,a4
     f2c:	fff78993          	add	s3,a5,-1
     f30:	99ba                	add	s3,s3,a4
     f32:	377d                	addw	a4,a4,-1
     f34:	1702                	sll	a4,a4,0x20
     f36:	9301                	srl	a4,a4,0x20
     f38:	40e989b3          	sub	s3,s3,a4
     f3c:	fff94583          	lbu	a1,-1(s2)
     f40:	8526                	mv	a0,s1
     f42:	00000097          	auipc	ra,0x0
     f46:	f56080e7          	jalr	-170(ra) # e98 <putc>
     f4a:	197d                	add	s2,s2,-1
     f4c:	ff3918e3          	bne	s2,s3,f3c <printint+0x82>
     f50:	70e2                	ld	ra,56(sp)
     f52:	7442                	ld	s0,48(sp)
     f54:	74a2                	ld	s1,40(sp)
     f56:	7902                	ld	s2,32(sp)
     f58:	69e2                	ld	s3,24(sp)
     f5a:	6121                	add	sp,sp,64
     f5c:	8082                	ret
     f5e:	40b005bb          	negw	a1,a1
     f62:	4885                	li	a7,1
     f64:	bf85                	j	ed4 <printint+0x1a>

0000000000000f66 <vprintf>:
     f66:	715d                	add	sp,sp,-80
     f68:	e486                	sd	ra,72(sp)
     f6a:	e0a2                	sd	s0,64(sp)
     f6c:	fc26                	sd	s1,56(sp)
     f6e:	f84a                	sd	s2,48(sp)
     f70:	f44e                	sd	s3,40(sp)
     f72:	f052                	sd	s4,32(sp)
     f74:	ec56                	sd	s5,24(sp)
     f76:	e85a                	sd	s6,16(sp)
     f78:	e45e                	sd	s7,8(sp)
     f7a:	e062                	sd	s8,0(sp)
     f7c:	0880                	add	s0,sp,80
     f7e:	0005c903          	lbu	s2,0(a1)
     f82:	18090c63          	beqz	s2,111a <vprintf+0x1b4>
     f86:	8aaa                	mv	s5,a0
     f88:	8bb2                	mv	s7,a2
     f8a:	00158493          	add	s1,a1,1
     f8e:	4981                	li	s3,0
     f90:	02500a13          	li	s4,37
     f94:	4b55                	li	s6,21
     f96:	a839                	j	fb4 <vprintf+0x4e>
     f98:	85ca                	mv	a1,s2
     f9a:	8556                	mv	a0,s5
     f9c:	00000097          	auipc	ra,0x0
     fa0:	efc080e7          	jalr	-260(ra) # e98 <putc>
     fa4:	a019                	j	faa <vprintf+0x44>
     fa6:	01498d63          	beq	s3,s4,fc0 <vprintf+0x5a>
     faa:	0485                	add	s1,s1,1
     fac:	fff4c903          	lbu	s2,-1(s1)
     fb0:	16090563          	beqz	s2,111a <vprintf+0x1b4>
     fb4:	fe0999e3          	bnez	s3,fa6 <vprintf+0x40>
     fb8:	ff4910e3          	bne	s2,s4,f98 <vprintf+0x32>
     fbc:	89d2                	mv	s3,s4
     fbe:	b7f5                	j	faa <vprintf+0x44>
     fc0:	13490263          	beq	s2,s4,10e4 <vprintf+0x17e>
     fc4:	f9d9079b          	addw	a5,s2,-99
     fc8:	0ff7f793          	zext.b	a5,a5
     fcc:	12fb6563          	bltu	s6,a5,10f6 <vprintf+0x190>
     fd0:	f9d9079b          	addw	a5,s2,-99
     fd4:	0ff7f713          	zext.b	a4,a5
     fd8:	10eb6f63          	bltu	s6,a4,10f6 <vprintf+0x190>
     fdc:	00271793          	sll	a5,a4,0x2
     fe0:	00000717          	auipc	a4,0x0
     fe4:	67070713          	add	a4,a4,1648 # 1650 <malloc+0x438>
     fe8:	97ba                	add	a5,a5,a4
     fea:	439c                	lw	a5,0(a5)
     fec:	97ba                	add	a5,a5,a4
     fee:	8782                	jr	a5
     ff0:	008b8913          	add	s2,s7,8
     ff4:	4685                	li	a3,1
     ff6:	4629                	li	a2,10
     ff8:	000ba583          	lw	a1,0(s7)
     ffc:	8556                	mv	a0,s5
     ffe:	00000097          	auipc	ra,0x0
    1002:	ebc080e7          	jalr	-324(ra) # eba <printint>
    1006:	8bca                	mv	s7,s2
    1008:	4981                	li	s3,0
    100a:	b745                	j	faa <vprintf+0x44>
    100c:	008b8913          	add	s2,s7,8
    1010:	4681                	li	a3,0
    1012:	4629                	li	a2,10
    1014:	000ba583          	lw	a1,0(s7)
    1018:	8556                	mv	a0,s5
    101a:	00000097          	auipc	ra,0x0
    101e:	ea0080e7          	jalr	-352(ra) # eba <printint>
    1022:	8bca                	mv	s7,s2
    1024:	4981                	li	s3,0
    1026:	b751                	j	faa <vprintf+0x44>
    1028:	008b8913          	add	s2,s7,8
    102c:	4681                	li	a3,0
    102e:	4641                	li	a2,16
    1030:	000ba583          	lw	a1,0(s7)
    1034:	8556                	mv	a0,s5
    1036:	00000097          	auipc	ra,0x0
    103a:	e84080e7          	jalr	-380(ra) # eba <printint>
    103e:	8bca                	mv	s7,s2
    1040:	4981                	li	s3,0
    1042:	b7a5                	j	faa <vprintf+0x44>
    1044:	008b8c13          	add	s8,s7,8
    1048:	000bb983          	ld	s3,0(s7)
    104c:	03000593          	li	a1,48
    1050:	8556                	mv	a0,s5
    1052:	00000097          	auipc	ra,0x0
    1056:	e46080e7          	jalr	-442(ra) # e98 <putc>
    105a:	07800593          	li	a1,120
    105e:	8556                	mv	a0,s5
    1060:	00000097          	auipc	ra,0x0
    1064:	e38080e7          	jalr	-456(ra) # e98 <putc>
    1068:	4941                	li	s2,16
    106a:	00000b97          	auipc	s7,0x0
    106e:	63eb8b93          	add	s7,s7,1598 # 16a8 <digits>
    1072:	03c9d793          	srl	a5,s3,0x3c
    1076:	97de                	add	a5,a5,s7
    1078:	0007c583          	lbu	a1,0(a5)
    107c:	8556                	mv	a0,s5
    107e:	00000097          	auipc	ra,0x0
    1082:	e1a080e7          	jalr	-486(ra) # e98 <putc>
    1086:	0992                	sll	s3,s3,0x4
    1088:	397d                	addw	s2,s2,-1
    108a:	fe0914e3          	bnez	s2,1072 <vprintf+0x10c>
    108e:	8be2                	mv	s7,s8
    1090:	4981                	li	s3,0
    1092:	bf21                	j	faa <vprintf+0x44>
    1094:	008b8993          	add	s3,s7,8
    1098:	000bb903          	ld	s2,0(s7)
    109c:	02090163          	beqz	s2,10be <vprintf+0x158>
    10a0:	00094583          	lbu	a1,0(s2)
    10a4:	c9a5                	beqz	a1,1114 <vprintf+0x1ae>
    10a6:	8556                	mv	a0,s5
    10a8:	00000097          	auipc	ra,0x0
    10ac:	df0080e7          	jalr	-528(ra) # e98 <putc>
    10b0:	0905                	add	s2,s2,1
    10b2:	00094583          	lbu	a1,0(s2)
    10b6:	f9e5                	bnez	a1,10a6 <vprintf+0x140>
    10b8:	8bce                	mv	s7,s3
    10ba:	4981                	li	s3,0
    10bc:	b5fd                	j	faa <vprintf+0x44>
    10be:	00000917          	auipc	s2,0x0
    10c2:	58a90913          	add	s2,s2,1418 # 1648 <malloc+0x430>
    10c6:	02800593          	li	a1,40
    10ca:	bff1                	j	10a6 <vprintf+0x140>
    10cc:	008b8913          	add	s2,s7,8
    10d0:	000bc583          	lbu	a1,0(s7)
    10d4:	8556                	mv	a0,s5
    10d6:	00000097          	auipc	ra,0x0
    10da:	dc2080e7          	jalr	-574(ra) # e98 <putc>
    10de:	8bca                	mv	s7,s2
    10e0:	4981                	li	s3,0
    10e2:	b5e1                	j	faa <vprintf+0x44>
    10e4:	02500593          	li	a1,37
    10e8:	8556                	mv	a0,s5
    10ea:	00000097          	auipc	ra,0x0
    10ee:	dae080e7          	jalr	-594(ra) # e98 <putc>
    10f2:	4981                	li	s3,0
    10f4:	bd5d                	j	faa <vprintf+0x44>
    10f6:	02500593          	li	a1,37
    10fa:	8556                	mv	a0,s5
    10fc:	00000097          	auipc	ra,0x0
    1100:	d9c080e7          	jalr	-612(ra) # e98 <putc>
    1104:	85ca                	mv	a1,s2
    1106:	8556                	mv	a0,s5
    1108:	00000097          	auipc	ra,0x0
    110c:	d90080e7          	jalr	-624(ra) # e98 <putc>
    1110:	4981                	li	s3,0
    1112:	bd61                	j	faa <vprintf+0x44>
    1114:	8bce                	mv	s7,s3
    1116:	4981                	li	s3,0
    1118:	bd49                	j	faa <vprintf+0x44>
    111a:	60a6                	ld	ra,72(sp)
    111c:	6406                	ld	s0,64(sp)
    111e:	74e2                	ld	s1,56(sp)
    1120:	7942                	ld	s2,48(sp)
    1122:	79a2                	ld	s3,40(sp)
    1124:	7a02                	ld	s4,32(sp)
    1126:	6ae2                	ld	s5,24(sp)
    1128:	6b42                	ld	s6,16(sp)
    112a:	6ba2                	ld	s7,8(sp)
    112c:	6c02                	ld	s8,0(sp)
    112e:	6161                	add	sp,sp,80
    1130:	8082                	ret

0000000000001132 <fprintf>:
    1132:	715d                	add	sp,sp,-80
    1134:	ec06                	sd	ra,24(sp)
    1136:	e822                	sd	s0,16(sp)
    1138:	1000                	add	s0,sp,32
    113a:	e010                	sd	a2,0(s0)
    113c:	e414                	sd	a3,8(s0)
    113e:	e818                	sd	a4,16(s0)
    1140:	ec1c                	sd	a5,24(s0)
    1142:	03043023          	sd	a6,32(s0)
    1146:	03143423          	sd	a7,40(s0)
    114a:	fe843423          	sd	s0,-24(s0)
    114e:	8622                	mv	a2,s0
    1150:	00000097          	auipc	ra,0x0
    1154:	e16080e7          	jalr	-490(ra) # f66 <vprintf>
    1158:	60e2                	ld	ra,24(sp)
    115a:	6442                	ld	s0,16(sp)
    115c:	6161                	add	sp,sp,80
    115e:	8082                	ret

0000000000001160 <printf>:
    1160:	711d                	add	sp,sp,-96
    1162:	ec06                	sd	ra,24(sp)
    1164:	e822                	sd	s0,16(sp)
    1166:	1000                	add	s0,sp,32
    1168:	e40c                	sd	a1,8(s0)
    116a:	e810                	sd	a2,16(s0)
    116c:	ec14                	sd	a3,24(s0)
    116e:	f018                	sd	a4,32(s0)
    1170:	f41c                	sd	a5,40(s0)
    1172:	03043823          	sd	a6,48(s0)
    1176:	03143c23          	sd	a7,56(s0)
    117a:	00840613          	add	a2,s0,8
    117e:	fec43423          	sd	a2,-24(s0)
    1182:	85aa                	mv	a1,a0
    1184:	4505                	li	a0,1
    1186:	00000097          	auipc	ra,0x0
    118a:	de0080e7          	jalr	-544(ra) # f66 <vprintf>
    118e:	60e2                	ld	ra,24(sp)
    1190:	6442                	ld	s0,16(sp)
    1192:	6125                	add	sp,sp,96
    1194:	8082                	ret

0000000000001196 <free>:
    1196:	1141                	add	sp,sp,-16
    1198:	e422                	sd	s0,8(sp)
    119a:	0800                	add	s0,sp,16
    119c:	ff050693          	add	a3,a0,-16
    11a0:	00000797          	auipc	a5,0x0
    11a4:	5287b783          	ld	a5,1320(a5) # 16c8 <freep>
    11a8:	a02d                	j	11d2 <free+0x3c>
    11aa:	4618                	lw	a4,8(a2)
    11ac:	9f2d                	addw	a4,a4,a1
    11ae:	fee52c23          	sw	a4,-8(a0)
    11b2:	6398                	ld	a4,0(a5)
    11b4:	6310                	ld	a2,0(a4)
    11b6:	a83d                	j	11f4 <free+0x5e>
    11b8:	ff852703          	lw	a4,-8(a0)
    11bc:	9f31                	addw	a4,a4,a2
    11be:	c798                	sw	a4,8(a5)
    11c0:	ff053683          	ld	a3,-16(a0)
    11c4:	a091                	j	1208 <free+0x72>
    11c6:	6398                	ld	a4,0(a5)
    11c8:	00e7e463          	bltu	a5,a4,11d0 <free+0x3a>
    11cc:	00e6ea63          	bltu	a3,a4,11e0 <free+0x4a>
    11d0:	87ba                	mv	a5,a4
    11d2:	fed7fae3          	bgeu	a5,a3,11c6 <free+0x30>
    11d6:	6398                	ld	a4,0(a5)
    11d8:	00e6e463          	bltu	a3,a4,11e0 <free+0x4a>
    11dc:	fee7eae3          	bltu	a5,a4,11d0 <free+0x3a>
    11e0:	ff852583          	lw	a1,-8(a0)
    11e4:	6390                	ld	a2,0(a5)
    11e6:	02059813          	sll	a6,a1,0x20
    11ea:	01c85713          	srl	a4,a6,0x1c
    11ee:	9736                	add	a4,a4,a3
    11f0:	fae60de3          	beq	a2,a4,11aa <free+0x14>
    11f4:	fec53823          	sd	a2,-16(a0)
    11f8:	4790                	lw	a2,8(a5)
    11fa:	02061593          	sll	a1,a2,0x20
    11fe:	01c5d713          	srl	a4,a1,0x1c
    1202:	973e                	add	a4,a4,a5
    1204:	fae68ae3          	beq	a3,a4,11b8 <free+0x22>
    1208:	e394                	sd	a3,0(a5)
    120a:	00000717          	auipc	a4,0x0
    120e:	4af73f23          	sd	a5,1214(a4) # 16c8 <freep>
    1212:	6422                	ld	s0,8(sp)
    1214:	0141                	add	sp,sp,16
    1216:	8082                	ret

0000000000001218 <malloc>:
    1218:	7139                	add	sp,sp,-64
    121a:	fc06                	sd	ra,56(sp)
    121c:	f822                	sd	s0,48(sp)
    121e:	f426                	sd	s1,40(sp)
    1220:	f04a                	sd	s2,32(sp)
    1222:	ec4e                	sd	s3,24(sp)
    1224:	e852                	sd	s4,16(sp)
    1226:	e456                	sd	s5,8(sp)
    1228:	e05a                	sd	s6,0(sp)
    122a:	0080                	add	s0,sp,64
    122c:	02051493          	sll	s1,a0,0x20
    1230:	9081                	srl	s1,s1,0x20
    1232:	04bd                	add	s1,s1,15
    1234:	8091                	srl	s1,s1,0x4
    1236:	0014899b          	addw	s3,s1,1
    123a:	0485                	add	s1,s1,1
    123c:	00000517          	auipc	a0,0x0
    1240:	48c53503          	ld	a0,1164(a0) # 16c8 <freep>
    1244:	c515                	beqz	a0,1270 <malloc+0x58>
    1246:	611c                	ld	a5,0(a0)
    1248:	4798                	lw	a4,8(a5)
    124a:	02977f63          	bgeu	a4,s1,1288 <malloc+0x70>
    124e:	8a4e                	mv	s4,s3
    1250:	0009871b          	sext.w	a4,s3
    1254:	6685                	lui	a3,0x1
    1256:	00d77363          	bgeu	a4,a3,125c <malloc+0x44>
    125a:	6a05                	lui	s4,0x1
    125c:	000a0b1b          	sext.w	s6,s4
    1260:	004a1a1b          	sllw	s4,s4,0x4
    1264:	00000917          	auipc	s2,0x0
    1268:	46490913          	add	s2,s2,1124 # 16c8 <freep>
    126c:	5afd                	li	s5,-1
    126e:	a895                	j	12e2 <malloc+0xca>
    1270:	00001797          	auipc	a5,0x1
    1274:	84878793          	add	a5,a5,-1976 # 1ab8 <base>
    1278:	00000717          	auipc	a4,0x0
    127c:	44f73823          	sd	a5,1104(a4) # 16c8 <freep>
    1280:	e39c                	sd	a5,0(a5)
    1282:	0007a423          	sw	zero,8(a5)
    1286:	b7e1                	j	124e <malloc+0x36>
    1288:	02e48c63          	beq	s1,a4,12c0 <malloc+0xa8>
    128c:	4137073b          	subw	a4,a4,s3
    1290:	c798                	sw	a4,8(a5)
    1292:	02071693          	sll	a3,a4,0x20
    1296:	01c6d713          	srl	a4,a3,0x1c
    129a:	97ba                	add	a5,a5,a4
    129c:	0137a423          	sw	s3,8(a5)
    12a0:	00000717          	auipc	a4,0x0
    12a4:	42a73423          	sd	a0,1064(a4) # 16c8 <freep>
    12a8:	01078513          	add	a0,a5,16
    12ac:	70e2                	ld	ra,56(sp)
    12ae:	7442                	ld	s0,48(sp)
    12b0:	74a2                	ld	s1,40(sp)
    12b2:	7902                	ld	s2,32(sp)
    12b4:	69e2                	ld	s3,24(sp)
    12b6:	6a42                	ld	s4,16(sp)
    12b8:	6aa2                	ld	s5,8(sp)
    12ba:	6b02                	ld	s6,0(sp)
    12bc:	6121                	add	sp,sp,64
    12be:	8082                	ret
    12c0:	6398                	ld	a4,0(a5)
    12c2:	e118                	sd	a4,0(a0)
    12c4:	bff1                	j	12a0 <malloc+0x88>
    12c6:	01652423          	sw	s6,8(a0)
    12ca:	0541                	add	a0,a0,16
    12cc:	00000097          	auipc	ra,0x0
    12d0:	eca080e7          	jalr	-310(ra) # 1196 <free>
    12d4:	00093503          	ld	a0,0(s2)
    12d8:	d971                	beqz	a0,12ac <malloc+0x94>
    12da:	611c                	ld	a5,0(a0)
    12dc:	4798                	lw	a4,8(a5)
    12de:	fa9775e3          	bgeu	a4,s1,1288 <malloc+0x70>
    12e2:	00093703          	ld	a4,0(s2)
    12e6:	853e                	mv	a0,a5
    12e8:	fef719e3          	bne	a4,a5,12da <malloc+0xc2>
    12ec:	8552                	mv	a0,s4
    12ee:	00000097          	auipc	ra,0x0
    12f2:	b92080e7          	jalr	-1134(ra) # e80 <sbrk>
    12f6:	fd5518e3          	bne	a0,s5,12c6 <malloc+0xae>
    12fa:	4501                	li	a0,0
    12fc:	bf45                	j	12ac <malloc+0x94>
