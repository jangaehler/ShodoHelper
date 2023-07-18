import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stroke_order_animator/strokeOrderAnimationController.dart';
import 'package:stroke_order_animator/strokeOrderAnimator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  int _selectedIndex = 0;

  late List<StrokeOrderAnimationController> _strokeOrderAnimationControllers;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _strokeOrderAnimationControllers = [
      StrokeOrderAnimationController(
        "{'strokes': ['M 440 788 Q 497 731 535 718 Q 553 717 562 732 Q 569 748 564 767 Q 546 815 477 828 Q 438 841 421 834 Q 414 831 418 817 Q 421 804 440 788 Z', 'M 532 448 Q 532 547 546 570 Q 559 589 546 601 Q 524 620 486 636 Q 462 645 413 615 Q 371 599 306 589 Q 290 588 299 578 Q 309 568 324 562 Q 343 558 370 565 Q 406 575 441 587 Q 460 594 467 584 Q 473 566 475 538 Q 482 271 470 110 Q 469 80 459 67 Q 453 61 369 82 Q 342 95 344 79 Q 411 27 450 -13 Q 463 -32 480 -38 Q 490 -42 499 -32 Q 541 16 540 77 Q 533 207 532 403 L 532 448 Z', 'M 117 401 Q 104 401 102 392 Q 101 385 117 377 Q 163 352 192 363 Q 309 397 320 395 Q 333 392 323 365 Q 280 256 240 205 Q 200 147 126 86 Q 111 73 122 71 Q 132 70 153 80 Q 220 114 275 172 Q 327 224 394 362 Q 404 384 416 397 Q 431 409 422 419 Q 412 432 374 445 Q 353 455 305 434 Q 215 412 117 401 Z', 'M 567 407 Q 639 452 745 526 Q 767 542 793 552 Q 817 562 806 582 Q 793 601 765 618 Q 740 634 725 632 Q 712 631 715 616 Q 719 582 641 505 Q 601 465 556 420 C 535 399 542 391 567 407 Z', 'M 556 420 Q 543 436 532 448 C 512 470 515 427 532 403 Q 737 114 799 116 Q 871 126 933 135 Q 960 138 960 145 Q 961 152 930 165 Q 777 217 733 253 Q 678 296 567 407 L 556 420 Z'], 'medians': [[[428, 824], [503, 781], [533, 756], [539, 741]], [[309, 579], [358, 580], [462, 613], [482, 608], [508, 581], [505, 121], [500, 59], [478, 24], [355, 78]], [[110, 391], [149, 384], [198, 387], [322, 418], [339, 417], [367, 402], [345, 333], [273, 208], [201, 129], [125, 78]], [[725, 621], [743, 596], [749, 578], [743, 570], [656, 489], [569, 421], [569, 415]], [[532, 441], [551, 399], [568, 378], [678, 259], [750, 194], [801, 163], [954, 145]]], 'radStrokes': [1, 2, 3, 4]}",
        this,
        onQuizCompleteCallback: (summary) {
          Fluttertoast.showToast(
              msg: [
                "Quiz finished. ",
                summary.nTotalMistakes.toString(),
                " mistakes"
              ].join());
        },
      ),
      StrokeOrderAnimationController(
          "{'strokes': ['M 272 567 Q 306 613 342 669 Q 370 718 395 743 Q 405 753 400 769 Q 396 782 365 808 Q 337 827 316 828 Q 297 827 305 802 Q 318 769 306 741 Q 267 647 207 560 Q 150 476 72 385 Q 60 375 58 367 Q 54 355 70 358 Q 82 359 109 384 Q 155 421 213 493 Q 226 509 241 527 L 272 567 Z', 'M 241 527 Q 262 506 258 375 Q 258 374 258 370 Q 254 253 221 135 Q 215 114 224 80 Q 236 44 248 32 Q 267 16 279 44 Q 294 86 294 134 Q 303 420 314 485 Q 321 515 295 543 Q 289 549 272 567 C 251 589 227 553 241 527 Z', 'M 521 560 Q 561 621 602 708 Q 620 751 638 773 Q 645 786 639 799 Q 633 811 602 830 Q 572 846 554 843 Q 535 839 546 817 Q 561 795 552 757 Q 513 619 407 448 Q 398 436 397 430 Q 394 418 409 423 Q 439 432 503 532 L 521 560 Z', 'M 503 532 Q 527 510 555 520 Q 795 608 782 549 Q 783 543 743 468 Q 736 458 741 453 Q 745 447 756 459 Q 852 532 894 549 Q 904 552 905 561 Q 906 574 876 592 Q 852 605 828 621 Q 800 637 783 630 Q 686 590 521 560 C 492 555 479 550 503 532 Z', 'M 568 72 Q 531 81 494 91 Q 482 94 483 86 Q 484 79 494 71 Q 569 7 596 -33 Q 611 -49 626 -36 Q 659 -3 661 82 Q 655 149 655 345 Q 656 382 667 407 Q 676 426 659 439 Q 634 461 604 470 Q 585 477 577 469 Q 571 462 582 447 Q 619 384 603 127 Q 597 82 589 74 Q 582 67 568 72 Z', 'M 444 320 Q 419 262 385 208 Q 364 180 381 144 Q 388 128 409 139 Q 460 181 468 264 Q 472 295 467 319 Q 463 328 456 328 Q 449 327 444 320 Z', 'M 738 307 Q 789 249 847 168 Q 860 146 876 139 Q 885 138 893 146 Q 908 159 900 204 Q 891 264 743 338 Q 734 345 731 332 Q 728 319 738 307 Z'], 'medians': [[[317, 812], [342, 786], [353, 759], [303, 663], [249, 577], [181, 485], [93, 386], [68, 367]], [[273, 558], [274, 525], [285, 495], [284, 441], [273, 243], [256, 123], [260, 41]], [[556, 828], [574, 817], [595, 783], [584, 746], [539, 640], [481, 531], [428, 453], [406, 431]], [[513, 532], [704, 585], [796, 597], [813, 585], [827, 563], [798, 519], [746, 460]], [[586, 463], [615, 438], [632, 412], [627, 73], [616, 41], [604, 30], [558, 47], [490, 85]], [[455, 316], [437, 243], [397, 151]], [[742, 326], [812, 265], [856, 216], [871, 190], [878, 154]]], 'radStrokes': [0, 1]}",
          this),
      StrokeOrderAnimationController(
          "{'strokes': ['M 309 426 Q 423 471 435 474 Q 448 475 451 481 Q 454 488 445 497 Q 400 530 372 526 Q 366 522 366 514 Q 366 493 247 425 C 221 410 229 398 257 409 Q 264 412 278 416 L 309 426 Z', 'M 247 425 Q 202 446 190 445 Q 172 441 186 423 Q 208 386 196 234 Q 190 195 172 149 Q 154 104 94 43 Q 82 33 79 26 Q 78 20 88 21 Q 115 21 170 75 Q 230 144 246 279 Q 252 366 257 401 Q 258 405 257 409 C 258 420 258 420 247 425 Z', 'M 405 168 Q 339 128 335 128 Q 331 131 329 144 Q 332 333 341 380 Q 345 396 334 406 Q 321 419 309 426 C 284 443 260 440 278 416 Q 299 395 297 354 Q 301 191 290 135 Q 286 110 276 95 Q 266 76 274 58 Q 284 30 300 21 Q 310 14 319 31 Q 340 64 414 153 C 433 176 431 184 405 168 Z', 'M 414 153 Q 421 140 434 137 Q 443 134 451 146 Q 454 155 451 171 Q 447 187 429 200 Q 402 222 389 229 Q 383 232 380 223 Q 377 214 405 168 L 414 153 Z', 'M 372 332 Q 403 298 439 248 Q 449 233 460 229 Q 467 228 473 234 Q 483 243 476 275 Q 473 305 423 331 Q 392 347 374 354 Q 368 358 366 350 Q 365 340 372 332 Z', 'M 615 462 Q 684 489 722 496 Q 735 496 739 503 Q 742 510 732 520 Q 687 557 657 553 Q 651 550 650 541 Q 650 519 541 461 C 515 447 522 436 551 445 Q 563 449 581 453 L 615 462 Z', 'M 541 461 Q 540 462 537 463 Q 494 482 482 478 Q 466 474 480 456 Q 513 410 500 232 Q 494 186 476 130 Q 458 78 389 -1 Q 377 -13 375 -18 Q 374 -24 384 -23 Q 418 -20 472 45 Q 544 138 549 345 Q 546 408 551 438 Q 551 442 551 445 C 552 456 552 456 541 461 Z', 'M 639 413 Q 640 417 641 420 Q 645 436 634 446 Q 624 456 615 462 C 592 481 569 481 581 453 Q 580 453 581 452 Q 597 421 597 394 Q 601 183 586 111 Q 582 86 572 71 Q 562 53 569 34 Q 579 6 594 -3 Q 604 -10 614 7 Q 638 41 719 131 C 739 153 736 163 710 147 Q 637 102 632 103 Q 626 106 625 120 Q 628 325 637 398 L 639 413 Z', 'M 719 131 Q 746 80 756 76 Q 763 75 770 81 Q 777 90 778 111 Q 779 145 706 200 Q 697 206 692 206 Q 688 205 686 196 Q 686 190 710 147 L 719 131 Z', 'M 637 398 Q 662 379 679 350 Q 757 218 821 126 Q 833 108 855 106 Q 936 102 967 104 Q 980 104 986 110 Q 990 114 982 119 Q 865 177 829 213 Q 768 271 682 395 Q 675 411 660 413 Q 644 416 639 413 C 621 412 621 412 637 398 Z'], 'medians': [[[443, 485], [391, 492], [316, 444], [263, 426], [259, 416]], [[191, 433], [211, 419], [226, 397], [221, 254], [212, 204], [193, 147], [167, 101], [115, 45], [86, 27]], [[284, 414], [310, 403], [318, 388], [310, 123], [320, 94], [367, 123], [399, 151], [397, 158]], [[388, 220], [427, 174], [437, 152]], [[373, 346], [448, 280], [462, 244]], [[731, 507], [676, 518], [617, 482], [570, 461], [557, 461], [556, 454]], [[484, 467], [521, 435], [527, 316], [514, 194], [495, 124], [461, 60], [415, 6], [381, -17]], [[587, 453], [617, 428], [612, 175], [606, 121], [614, 69], [658, 92], [702, 130], [701, 137]], [[696, 197], [751, 123], [760, 86]], [[645, 405], [661, 398], [677, 379], [773, 239], [847, 152], [866, 140], [979, 112]]], 'radStrokes': [0, 1, 2, 3, 4]}",
          this),
      StrokeOrderAnimationController(
          "{'strokes': ['M 407 333 Q 417 358 430 381 Q 464 460 477 550 L 482 584 Q 500 716 521 761 Q 531 783 512 792 Q 458 831 426 820 Q 410 814 419 797 Q 450 740 428 571 L 421 534 Q 394 420 360 355 L 339 317 Q 324 295 309 271 Q 266 208 186 147 Q 167 131 141 114 Q 125 101 107 87 Q 92 75 106 73 Q 122 73 162 90 Q 243 130 302 190 Q 350 235 380 282 L 407 333 Z', 'M 477 550 Q 544 572 594 579 Q 616 583 622 578 Q 626 571 621 554 Q 497 139 642 65 Q 678 44 746 35 Q 884 22 968 74 Q 987 84 980 107 Q 964 165 961 251 Q 960 270 954 269 Q 948 270 942 251 Q 908 149 879 125 Q 861 109 804 103 Q 740 96 687 113 Q 642 128 628 160 Q 606 200 615 289 Q 628 386 674 503 Q 693 554 726 581 Q 742 594 741 607 Q 740 619 670 651 Q 655 661 637 646 Q 588 612 505 591 Q 493 588 482 584 L 428 571 Q 367 558 308 541 Q 262 531 188 530 Q 173 531 176 516 Q 179 503 206 487 Q 237 469 275 485 Q 354 513 421 534 L 477 550 Z', 'M 380 282 Q 455 216 463 214 Q 470 213 477 222 Q 487 235 473 272 Q 463 306 407 333 L 360 355 Q 312 379 284 389 Q 277 393 275 382 Q 275 370 285 361 Q 310 342 339 317 L 380 282 Z'], 'medians': [[[429, 806], [450, 794], [475, 764], [448, 530], [409, 398], [354, 291], [303, 223], [214, 142], [110, 80]], [[185, 520], [222, 506], [259, 507], [619, 606], [661, 605], [669, 595], [661, 560], [631, 482], [602, 369], [588, 274], [588, 225], [596, 172], [612, 133], [639, 102], [671, 85], [741, 68], [807, 67], [889, 83], [920, 100], [931, 115], [953, 263]], [[285, 378], [425, 285], [452, 256], [465, 222]]], 'radStrokes': [2]}",
          this),
      StrokeOrderAnimationController(
          "{'strokes': ['M 520 564 Q 643 660 682 671 Q 704 678 697 695 Q 694 711 626 752 Q 607 764 582 755 Q 512 731 408 705 Q 381 698 315 701 Q 290 702 299 681 Q 306 668 326 655 Q 359 636 394 656 Q 421 665 555 707 Q 568 713 581 705 Q 593 696 587 683 Q 551 634 509 576 C 491 552 496 546 520 564 Z', 'M 558 230 Q 576 363 550 493 Q 541 533 520 564 L 509 576 Q 499 589 483 596 Q 473 603 467 595 Q 463 591 470 577 Q 525 462 507 297 Q 504 291 504 283 Q 495 216 462 211 Q 456 211 451 211 Q 376 221 368 216 Q 364 215 380 203 Q 441 160 477 121 Q 496 105 513 114 Q 541 132 556 220 L 558 230 Z', 'M 231 429 Q 219 435 189 441 Q 176 445 173 439 Q 166 433 175 417 Q 200 363 214 276 Q 217 249 232 232 Q 250 210 255 225 Q 259 238 259 262 L 255 293 Q 243 378 243 403 C 242 424 242 424 231 429 Z', 'M 386 317 Q 399 389 420 411 Q 441 436 418 449 Q 399 459 374 474 Q 355 483 338 472 Q 310 451 231 429 C 202 421 214 396 243 403 Q 282 413 322 424 Q 341 428 347 421 Q 354 417 349 386 Q 345 355 338 318 C 333 289 380 288 386 317 Z', 'M 259 262 Q 266 261 277 264 Q 314 274 399 287 Q 409 288 409 297 Q 409 304 386 317 C 372 325 367 324 338 318 Q 337 318 336 318 Q 290 302 255 293 C 226 285 229 263 259 262 Z', 'M 753 317 Q 781 363 808 434 Q 818 461 836 478 Q 852 493 840 504 Q 828 514 799 524 Q 777 531 753 517 Q 729 507 697 495 Q 666 485 610 476 Q 597 475 593 468 Q 590 461 607 455 Q 641 443 687 458 Q 729 477 737 477 Q 759 477 756 453 Q 743 389 718 346 Q 715 342 713 338 L 686 303 Q 638 257 559 231 Q 558 231 558 230 C 544 224 544 224 556 220 Q 584 199 676 246 Q 677 249 682 250 Q 701 262 718 277 L 753 317 Z', 'M 718 277 Q 832 187 836 186 Q 843 185 849 194 Q 858 207 843 242 Q 833 275 753 317 L 713 338 Q 643 374 603 389 Q 596 393 595 382 Q 595 370 605 363 Q 644 336 686 303 L 718 277 Z', 'M 516 38 Q 565 39 611 43 Q 750 52 863 33 Q 890 29 896 39 Q 906 54 892 68 Q 817 140 757 120 Q 379 71 165 70 Q 159 70 153 70 Q 137 70 136 58 Q 135 43 155 27 Q 174 12 209 -2 Q 221 -6 241 2 Q 334 27 516 38 Z'], 'medians': [[[309, 689], [333, 677], [359, 673], [570, 730], [607, 725], [633, 697], [541, 593], [525, 578], [518, 579]], [[475, 590], [512, 534], [536, 421], [536, 302], [521, 216], [495, 172], [461, 179], [371, 215]], [[182, 431], [214, 398], [244, 231]], [[242, 426], [251, 420], [348, 449], [377, 435], [385, 426], [366, 341], [344, 324]], [[263, 270], [274, 281], [335, 297], [399, 297]], [[600, 466], [662, 468], [740, 494], [773, 494], [790, 485], [785, 451], [760, 379], [737, 333], [700, 287], [638, 245], [563, 224]], [[605, 379], [780, 267], [813, 239], [840, 195]], [[150, 56], [175, 44], [224, 34], [369, 53], [779, 84], [824, 76], [881, 51]]]}",
          this),
      StrokeOrderAnimationController(
          "{'strokes': ['M 280 783 Q 270 787 232 791 Q 219 792 217 787 Q 211 780 221 765 Q 249 722 274 646 Q 280 624 295 610 Q 314 591 318 606 Q 319 612 319 618 L 316 649 Q 315 653 315 656 Q 299 725 292 751 C 284 780 284 782 280 783 Z', 'M 687 660 Q 687 659 688 656 Q 692 640 704 640 Q 723 643 755 693 Q 776 742 813 767 Q 832 780 818 796 Q 802 814 757 844 Q 741 854 667 839 Q 568 833 410 803 Q 334 790 280 783 C 250 779 263 743 292 751 Q 329 763 385 772 L 410 777 Q 468 787 544 797 L 590 802 Q 698 820 726 806 Q 732 802 726 780 Q 702 704 694 689 Q 691 686 690 682 C 683 667 683 667 687 660 Z', 'M 447 665 Q 447 666 448 668 Q 448 704 415 771 Q 412 775 410 777 C 390 799 374 800 385 772 L 386 771 Q 392 734 394 730 Q 397 687 422 661 C 441 640 441 640 447 665 Z', 'M 556 684 Q 560 691 566 701 Q 578 717 591 738 Q 595 748 606 759 Q 619 771 612 780 Q 605 790 590 802 C 567 821 541 827 544 797 Q 548 770 531 701 Q 525 689 523 678 C 516 649 541 658 556 684 Z', 'M 319 618 Q 325 618 332 619 Q 444 643 687 660 C 713 662 713 662 690 682 Q 683 689 672 696 Q 656 705 556 684 L 523 678 Q 483 672 447 665 L 422 661 Q 365 657 316 649 C 286 644 289 616 319 618 Z', 'M 532 534 Q 583 544 635 552 Q 683 562 690 568 Q 697 575 694 582 Q 688 592 664 599 Q 643 605 560 581 Q 448 556 358 547 C 328 544 339 523 369 518 Q 387 512 470 523 Q 480 526 491 526 L 532 534 Z', 'M 358 547 Q 342 557 327 562 Q 303 566 295 561 Q 288 555 296 543 Q 323 510 311 318 Q 308 302 281 265 Q 271 249 281 237 Q 291 227 315 212 Q 328 205 344 218 C 355 225 355 265 355 295 Q 354 449 369 518 C 373 538 373 538 358 547 Z', 'M 555 452 Q 583 459 617 465 Q 647 472 651 476 Q 657 482 654 488 Q 650 495 629 501 Q 611 504 558 487 L 502 472 Q 465 466 429 462 Q 404 458 422 446 Q 449 431 492 440 Q 495 441 502 441 L 555 452 Z', 'M 550 369 Q 583 376 617 381 Q 650 388 654 392 Q 661 398 658 404 Q 654 411 633 418 Q 614 422 552 403 L 502 391 Q 462 385 418 382 Q 393 378 410 366 Q 437 348 481 358 Q 488 361 502 360 L 550 369 Z', 'M 552 403 Q 553 428 555 452 L 558 487 Q 564 505 557 513 Q 544 526 532 534 C 508 551 478 553 491 526 Q 500 511 502 472 L 502 441 Q 502 422 502 391 L 502 360 Q 503 335 503 304 C 503 274 546 282 547 312 Q 548 342 550 369 L 552 403 Z', 'M 344 218 Q 440 272 680 291 Q 728 298 744 285 Q 772 257 724 61 Q 717 39 701 28 Q 695 25 626 38 Q 608 47 607 38 Q 606 28 625 12 Q 656 -28 667 -59 Q 683 -87 706 -71 Q 758 -37 775 6 Q 787 46 820 211 Q 826 251 845 269 Q 861 285 853 297 Q 840 310 788 337 Q 763 350 730 343 Q 684 330 630 325 Q 587 319 547 312 L 503 304 Q 442 295 385 281 Q 351 271 355 295 C 333 316 317 205 344 218 Z', 'M 199 187 Q 177 139 148 96 Q 127 65 145 29 Q 152 11 173 23 Q 222 60 224 129 Q 230 162 223 187 Q 217 196 212 197 Q 203 196 199 187 Z', 'M 309 169 Q 327 87 350 73 Q 360 66 374 80 Q 381 90 381 112 Q 380 131 362 149 Q 337 180 324 190 Q 317 196 311 186 Q 307 179 309 169 Z', 'M 443 188 Q 461 119 485 108 Q 497 102 509 116 Q 515 128 514 149 Q 505 180 456 211 Q 449 215 444 206 Q 440 199 443 188 Z', 'M 578 188 Q 600 160 623 124 Q 632 111 645 108 Q 655 107 661 117 Q 668 129 666 155 Q 663 185 583 230 Q 570 236 564 235 Q 560 232 558 221 Q 559 211 578 188 Z'], 'medians': [[[227, 780], [259, 757], [264, 747], [307, 611]], [[287, 779], [308, 771], [524, 810], [681, 829], [733, 827], [751, 817], [767, 782], [704, 653]], [[395, 762], [406, 756], [425, 688], [440, 669]], [[552, 793], [574, 769], [546, 697], [528, 683]], [[325, 626], [334, 635], [354, 640], [571, 671], [667, 678], [676, 667]], [[366, 542], [381, 533], [403, 533], [494, 546], [616, 573], [683, 578]], [[301, 554], [331, 532], [338, 514], [333, 306], [315, 252], [329, 228]], [[424, 455], [481, 453], [605, 481], [644, 484]], [[413, 375], [431, 369], [470, 371], [600, 398], [648, 401]], [[498, 524], [530, 497], [526, 335], [509, 312]], [[346, 226], [372, 256], [468, 281], [700, 315], [742, 317], [769, 309], [796, 281], [771, 124], [740, 15], [700, -19], [637, 25], [624, 25], [615, 34]], [[212, 186], [197, 123], [161, 34]], [[320, 179], [352, 119], [358, 89]], [[454, 199], [480, 159], [493, 126]], [[567, 225], [626, 169], [647, 124]]], 'radStrokes': [0, 1, 2, 3, 4]}",
          this),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _strokeOrderAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character Animator"),
      ),
      body: ChangeNotifierProvider<StrokeOrderAnimationController>.value(
        value: _strokeOrderAnimationControllers[_selectedIndex],
        child: Consumer<StrokeOrderAnimationController>(
            builder: (context, controller, child) {
              return Center(
                child: SizedBox(
                  width: 500,
                  child: Column(
                    children: <Widget>[
                      if (kIsWeb ||
                          Platform.isLinux ||
                          Platform.isWindows ||
                          Platform.isMacOS)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                                onPressed: () {
                                  if (!controller.isQuizzing)
                                    _pageController.previousPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                },
                                child: Text("Previous character")),
                            Spacer(),
                            MaterialButton(
                                onPressed: () {
                                  if (!controller.isQuizzing)
                                    _pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                },
                                child: Text("Next character")),
                          ],
                        ),
                      Expanded(
                        child: PageView(
                          physics: controller.isQuizzing
                              ? NeverScrollableScrollPhysics()
                              : ScrollPhysics(),
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            _strokeOrderAnimationControllers.length,
                                (index) => FittedBox(
                              child: StrokeOrderAnimator(
                                _strokeOrderAnimationControllers[index],
                                key: UniqueKey(),
                              ),
                            ),
                          ),
                          onPageChanged: (index) => {
                            setState(() {
                              _strokeOrderAnimationControllers[_selectedIndex]
                                  .stopAnimation();
                              _selectedIndex = index;
                            })
                          },
                        ),
                      ),
                      Flexible(
                        child: GridView(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                          ),
                          primary: false,
                          children: <Widget>[
                            MaterialButton(
                              onPressed: !controller.isQuizzing
                                  ? () {
                                if (!controller.isAnimating) {
                                  controller.startAnimation();
                                } else {
                                  controller.stopAnimation();
                                }
                              }
                                  : null,
                              child: controller.isAnimating
                                  ? Text("Stop animation")
                                  : Text("Start animation"),
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (!controller.isQuizzing) {
                                  controller.startQuiz();
                                } else {
                                  controller.stopQuiz();
                                }
                              },
                              child: controller.isQuizzing
                                  ? Text("Stop quiz")
                                  : Text("Start quiz"),
                            ),
                            MaterialButton(
                              onPressed: !controller.isQuizzing
                                  ? () {
                                controller.nextStroke();
                              }
                                  : null,
                              child: Text("Next stroke"),
                            ),
                            MaterialButton(
                              onPressed: !controller.isQuizzing
                                  ? () {
                                controller.previousStroke();
                              }
                                  : null,
                              child: Text("Previous stroke"),
                            ),
                            MaterialButton(
                              onPressed: !controller.isQuizzing
                                  ? () {
                                controller.showFullCharacter();
                              }
                                  : null,
                              child: Text("Show full character"),
                            ),
                            MaterialButton(
                              onPressed: () {
                                controller.reset();
                              },
                              child: Text("Reset"),
                            ),
                            MaterialButton(
                              onPressed: () {
                                controller.setShowOutline(!controller.showOutline);
                              },
                              child: controller.showOutline
                                  ? Text("Hide outline")
                                  : Text("Show Outline"),
                            ),
                            MaterialButton(
                              onPressed: () {
                                controller.setShowMedian(!controller.showMedian);
                              },
                              child: controller.showMedian
                                  ? Text("Hide medians")
                                  : Text("Show medians"),
                            ),
                            MaterialButton(
                              onPressed: () {
                                controller.setHighlightRadical(
                                    !controller.highlightRadical);
                              },
                              child: controller.highlightRadical
                                  ? Text("Unhighlight radical")
                                  : Text("Highlight radical"),
                            ),
                            MaterialButton(
                              onPressed: () {
                                controller
                                    .setShowUserStroke(!controller.showUserStroke);
                              },
                              child: controller.showUserStroke
                                  ? Text("Hide user strokes")
                                  : Text("Show user strokes"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}