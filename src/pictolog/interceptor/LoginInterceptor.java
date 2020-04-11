package pictolog.interceptor;

import java.util.Map;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import pictolog.vo.Member;

@SuppressWarnings("serial")
public class LoginInterceptor extends AbstractInterceptor {

	@Override
	public String intercept(ActionInvocation arg0) throws Exception {

		ActionContext context = arg0.getInvocationContext();
		Map<String, Object> session = context.getSession();

		Member member = (Member) session.get("login");
		if (member == null) {
			return Action.LOGIN;
		} else {
			return arg0.invoke();
		} // else
	} // intercept
}


