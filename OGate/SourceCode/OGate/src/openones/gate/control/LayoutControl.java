/**
 * Licensed to Open-Ones Group under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Open-Ones Group licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a
 * copy of the License at:
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package openones.gate.control;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import openones.corewa.control.BaseControl;
import openones.gate.Cons;

/**
 * @author Thach Le
 * 
 */
public class LayoutControl extends BaseControl {
    private final Logger LOG = Logger.getLogger(this.getClass().getName());
    private static int nmLogonUser = 0;

    @Override
    public void procInit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO Auto-generated method stub
        HttpSession session = req.getSession();
        //updateNmLogonUser(session, 0);
    }

    public static int updateNmLogonUser(HttpSession session, int delta) {
        // Update number of logon user
        Object nmLogonUserObj = session.getAttribute(Cons.SK_NMLOGON_USER);
        
        if (nmLogonUserObj != null) {
            nmLogonUser = (Integer) nmLogonUserObj;
        }

        nmLogonUser += delta;
        if (nmLogonUser < 0) {
            nmLogonUser = 0;
        }
        session.setAttribute(Cons.SK_NMLOGON_USER, nmLogonUser);
        
        return nmLogonUser;
    }
}