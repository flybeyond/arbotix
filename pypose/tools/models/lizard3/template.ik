@HEADER
/******************************************************************************
 * Inverse Kinematics for 4/6 legged bots using 3DOF lizard legs
 *   
 * Auto-Generated by NUKE!
 *   http://arbotix.googlecode.com
 *             
 * FRONT VIEW       ^        ==0         0==
 *     /\___/\      |       |  0==[___]==0  |
 *    /       \     Z       |               |  
 *
 * TOP VIEW
 *    \       /     ^    
 *     \_____/      |    
 *  ___|     |___   X
 *     |_____|
 *     /     \      Y->
 *    /       \
 *****************************************************************************/
@END_SECTION

@LEG_IK
/* Simple 3dof leg solver. X,Y,Z are the length from the Coxa rotate to the endpoint. */
ik_sol_t legIK(int X, int Y, int Z){
    ik_sol_t ans;    

    // first, make this a 2DOF problem... by solving coxa
    ans.coxa = radToServo(atan2(X,Y));
    long trueX = sqrt(sq((long)X)+sq((long)Y)) - L_COXA;
    long im = sqrt(sq((long)trueX)+sq((long)Z));    // length of imaginary leg
    
    // get femur angle above horizon...
    float q1 = -atan2(Z,trueX);
    long d1 = sq(L_FEMUR)-sq(L_TIBIA)+sq(im);
    long d2 = 2*L_FEMUR*im;
    float q2 = acos((float)d1/(float)d2);
    ans.femur = radToServo(q1+q2); 
    
    // and tibia angle from femur...
    d1 = sq(L_FEMUR)-sq(im)+sq(L_TIBIA);
    d2 = 2*L_TIBIA*L_FEMUR;
    ans.tibia = radToServo(acos((float)d1/(float)d2)-1.57);  
    
    return ans;
}
@END_SECTION
