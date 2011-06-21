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

import java.util.logging.Logger;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;

import openones.corewa.control.BaseControl;
import openones.gate.Cons;
import rocky.common.CommonUtil;

/**
 * @author Thach Le
 */
public class OGateBaseControl extends BaseControl {
    /** . */
    public static final String SK_MAINSCREEN = "MainScreen";
    public static final String K_FORM = "form";
    /**
     * Parameter name of Menu Item. Refer Jsp page leftmenu.jsp
     */
    static final String K_MENUID = "menuId";
    static final String K_MODULEID = "moduleId";
    static final String K_TABID = "tabId";
    static final String K_TABKEY = "tabKey";
    static final String K_TABMODULE = "tabModule";
    static final String K_TABMODULEID = "tabModuleId";
    static final String K_TABNAME = "tabName";
    static final String K_LANGCD = "langCd";
    public static final String K_MODULETABS = "moduleTabs";
    public static final String K_MINTAB_ORDERNO = "minTabOrderNo";

    public final Logger LOG = Logger.getLogger(this.getClass().getName());

    /**
     * 
     */
    public OGateBaseControl() {
        super();
    }
    /**
     * @param config
     */
    public OGateBaseControl(ServletConfig config) {
        super(config);
    }

    /**
     * Put the data of form bean into the request with key K_FORM ("form").
     * 
     * @param formBean
     */
    public void keepForm(Object formBean) {
        outForm.putRequest(K_FORM, formBean);
    }

    /**
     * Set screen identifier into the request/session with key "MainScreen".
     * 
     * @param screenId
     */
    public void setMainScreen(String screenId) {
        outForm.putRequest(SK_MAINSCREEN, screenId);
    }

    public void setMainScreen(Cons.Screens screenId) {
        outForm.putRequest(SK_MAINSCREEN, screenId);
    }

    public String getLangCd(HttpServletRequest req) {
        String langCd = (String) req.getSession().getAttribute(K_LANGCD);

        return (CommonUtil.isNNandNB(langCd) ? langCd : Cons.DEF_LANGCD);
    }
}
